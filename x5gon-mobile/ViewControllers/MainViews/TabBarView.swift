//
//  TabBarView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class TabBarView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - Properties

    /// This is a `UICollcetionView`which is used to save an ordered collection
    @IBOutlet var collectionView: UICollectionView!
    /// This is a `UIView` which is used as a `whiteBar` under the selected icon
    @IBOutlet var whiteBar: UIView!
    /// This a `NSLayoutConstrait` which is used to size the `whiteBar`
    @IBOutlet var whiteBarLeadingConstraint: NSLayoutConstraint!
    private let tabBarImages = ["home", "trending", "subscriptions", "User"]
    /// This variable is used to save the selected cell in `UICollectionView`
    var selectedIndex = 0

    // MARK: - Methods

    /// Customise `TabBarView`
    func customisation() {
        collectionView.delegate = self
        collectionView.dataSource = self
        backgroundColor = Environment.X5Color
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        NotificationCenter.default.addObserver(self, selector: #selector(animateMenu(notification:)), name: Notification.Name(rawValue: "scrollMenu"), object: nil)
    }

    /// Animate to show the Menu
    @objc func animateMenu(notification: Notification) {
        if let info = notification.userInfo {
            let userInfo = info as! [String: CGFloat]
            whiteBarLeadingConstraint.constant = whiteBar.bounds.width * userInfo["length"]!
            selectedIndex = Int(round(userInfo["length"]!))
            layoutIfNeeded()
            collectionView.reloadData()
        }
    }

    // MARK: - Delegates

    /**
     Asks `tabBarImages` for the number of items in the specified section.

     - Parameters:
        - collectionView: The collection view requesting this information.
        - section: An index number identifying a section in collectionView. This index value is 0-based.
     - returns:
     The number of rows in section.

     */
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return tabBarImages.count
    }

    /**
     Asks `tabBarImages` for the cell that corresponds to the specified item in the collection view.

     - Parameters:
        - collectionView: The collection view requesting this information.
        - indexPath: The index path that specifies the location of the item.
     - returns:
     A configured cell object. You must not return nil from this method.

     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TabBarCellCollectionViewCell
        var imageName = tabBarImages[indexPath.row]
        if selectedIndex == indexPath.row {
            imageName += "Selected"
        }
        cell.icon.image = UIImage(named: imageName)
        return cell
    }

    /**
     Asks the delegate for the size of the specified item’s cell.

     - Parameters:
        - collectionView: The collection view object displaying the flow layout.
        - indexPath: The index path of the item
        - collectionViewLayout:The layout object requesting the
     - returns:
     The width and height of the specified item. Both values must be greater than 0.

     */
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        // return CGSize.init(width: collectionView.bounds.width / 4, height: collectionView.bounds.height)
        return CGSize(width: UIScreen.main.bounds.width / 4, height: frame.height)
    }

    /**
     Tells the delegate that the item at the specified index path was selected.

     - Parameters:
        - collectionView: The collection view object displaying the flow layout.
        - indexPath: The index path of the item

     */
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndex != indexPath.row {
            selectedIndex = indexPath.row
            NotificationCenter.default.post(name: Notification.Name(rawValue: "didSelectMenu"), object: nil, userInfo: ["index": selectedIndex])
        }
    }

    // MARK: - View LifeCycle

    /**
     Called after the controller's view is loaded into memory. Load  `customisation` Method
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }

    /// Deinitialization Function
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
