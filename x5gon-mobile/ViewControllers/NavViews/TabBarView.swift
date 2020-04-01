//
//  TabBarView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class TabBarView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: Properties

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var whiteBar: UIView!
    @IBOutlet var whiteBarLeadingConstraint: NSLayoutConstraint!
    private let tabBarImages = ["home", "trending", "subscriptions", "account"]
    var selectedIndex = 0

    // MARK: Methods

    func customization() {
        collectionView.delegate = self
        collectionView.dataSource = self
        backgroundColor = Environment.X5Color
        NotificationCenter.default.addObserver(self, selector: #selector(animateMenu(notification:)), name: Notification.Name(rawValue: "scrollMenu"), object: nil)
    }

    @objc func animateMenu(notification: Notification) {
        if let info = notification.userInfo {
            let userInfo = info as! [String: CGFloat]
            whiteBarLeadingConstraint.constant = whiteBar.bounds.width * userInfo["length"]!
            selectedIndex = Int(round(userInfo["length"]!))
            layoutIfNeeded()
            collectionView.reloadData()
        }
    }

    // MARK: Delegates

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return tabBarImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TabBarCellCollectionViewCell
        var imageName = tabBarImages[indexPath.row]
        if selectedIndex == indexPath.row {
            imageName += "Selected"
        }
        cell.icon.image = UIImage(named: imageName)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 4, height: collectionView.bounds.height)
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndex != indexPath.row {
            selectedIndex = indexPath.row
            NotificationCenter.default.post(name: Notification.Name(rawValue: "didSelectMenu"), object: nil, userInfo: ["index": selectedIndex])
        }
    }

    // MARK: View LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        customization()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
