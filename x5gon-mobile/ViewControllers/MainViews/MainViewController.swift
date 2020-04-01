//
//  MainViewController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - Properties

    /// This is a `UIView` that is placed on the TabBar
    @IBOutlet var tabBarView: TabBarView!
    /// This is a `UICollectionView` that is used to save an ordered collection of `viewControllers` and present them using customizable layouts
    @IBOutlet var collectionView: UICollectionView!
    /// This is a variable to save a list of `UIView`s
    var views = [UIView]()

    var viewControllers = [UIViewController?]()

    // MARK: - Methods

    /**
     ### Customise View ###
     - Setup CollectionView
     - Setup TabbarView
     - Init ViewControllers
     - Setup Notification Centre
     */
    func customisation() {
        MainController.mainViewController = self

        view.backgroundColor = Environment.X5Color

        // CollectionView Setup
        collectionView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        collectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: view.bounds.height)

        // TabbarView setup
        view.addSubview(tabBarView)
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        guard let v = view else { return }
        _ = NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: tabBarView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        _ = NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: tabBarView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        _ = NSLayoutConstraint(item: v, attribute: .right, relatedBy: .equal, toItem: tabBarView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        tabBarView.heightAnchor.constraint(equalToConstant: 64).isActive = true

        // ViewControllers init
        let homeVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        let featuredVC = storyboard?.instantiateViewController(withIdentifier: "FeaturedViewController")
        let searchResultsVC = storyboard?.instantiateViewController(withIdentifier: "SearchResultsViewController")
        let userVC = storyboard?.instantiateViewController(withIdentifier: "UserViewController")
        MainController.homeViewController = (homeVC as! HomeViewController)
        MainController.featuredViewController = (featuredVC as! FeaturedViewController)
        MainController.searchResultsViewController = (searchResultsVC as! SearchResultsViewController)
        MainController.userViewController = (userVC as! UserViewController)

        viewControllers = [homeVC, featuredVC, searchResultsVC, userVC]
        for vc in viewControllers {
            addChild(vc!)
            vc!.didMove(toParent: self)

            if vc == homeVC {
                vc!.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 99)
            } else {
                vc!.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 95)
            }
            views.append(vc!.view)
        }
        collectionView.reloadData()

        // NotificationCenter setup
        NotificationCenter.default.addObserver(self, selector: #selector(scrollViews(notification:)), name: Notification.Name(rawValue: "didSelectMenu"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideBar(notification:)), name: NSNotification.Name("hide"), object: nil)
    }

    /// Scroll the menu, this will be called when a notification is being sent with value **didSelectMenu**
    @objc func scrollViews(notification: Notification) {
        if let info = notification.userInfo {
            let userInfo = info as! [String: Int]
            collectionView.scrollToItem(at: IndexPath(row: userInfo["index"]!, section: 0), at: .centeredHorizontally, animated: true)
        }
    }

    /// Hide the navigation bar,  this will be called when a notification is being sent with value **hide**
    @objc func hideBar(notification: NSNotification) {
        let state = notification.object as! Bool
        navigationController?.setNavigationBarHidden(state, animated: true)
    }

    // MARK: - Delegates

    /**
     Asks collectionView for the number of items in the specified section.

     - Parameters:
        - collectionView: The collection view requesting this information.
        - section: An index number identifying a section in collectionView. This index value is 0-based.
     - returns:
     The number of rows in section.

     */
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return views.count
    }

    /**
     Asks collectionView for the cell that corresponds to the specified item in the collection view.

     - Parameters:
        - collectionView: The collection view requesting this information.
        - indexPath: The index path that specifies the location of the item.
     - returns:
     A configured cell object. You must not return nil from this method.

     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.contentView.frame = collectionView.frame
        cell.contentView.addSubview(views[indexPath.row])
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
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height + 22)
    }

    /**
     Tells the delegate when the user scrolls the content view within the receiver.

     - Parameters:
        - scorllView: The scroll-view object in which the scrolling occurred.
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollIndex = scrollView.contentOffset.x / view.bounds.width
        NotificationCenter.default.post(name: Notification.Name(rawValue: "scrollMenu"), object: nil, userInfo: ["length": scrollIndex])
    }

    // MARK: - ViewController lifecycle

    /**
     Called after the controller's view is loaded into memory. Load  `customisation`
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        customisation()
    }

    /// Deinitialization Function
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
