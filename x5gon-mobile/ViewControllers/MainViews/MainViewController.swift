//
//  MainViewController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    /// This is a `UIView` that is placed on the TabBar
    @IBOutlet var tabBarView: TabBarView!
    /// This is a `UICollectionView` that is used to save an ordered collection of `viewControllers` and present them using customizable layouts
    @IBOutlet weak var collectionView: UICollectionView!
    /// This is a variable to save a list of `UIView`s
    var views = [UIView]()
    
    var viewControllers = [UIViewController?]()
    
    //MARK: - Methods
    /**
     ### Customise View ###
     - Setup CollectionView
     - Setup TabbarView
     - Init ViewControllers
     - Setup Notification Centre
     */
    func customisation()  {
        MainController.mainViewController = self
        
        self.view.backgroundColor = Environment.X5Color
        
        //CollectionView Setup
        self.collectionView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        self.collectionView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (self.view.bounds.height))
        
        //TabbarView setup
        self.view.addSubview(self.tabBarView)
        self.tabBarView.translatesAutoresizingMaskIntoConstraints = false
        guard let v = self.view else { return }
        let _ = NSLayoutConstraint.init(item: v, attribute: .top, relatedBy: .equal, toItem: self.tabBarView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: v, attribute: .left, relatedBy: .equal, toItem: self.tabBarView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: v, attribute: .right, relatedBy: .equal, toItem: self.tabBarView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        self.tabBarView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        //ViewControllers init
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        let featuredVC = self.storyboard?.instantiateViewController(withIdentifier: "FeaturedViewController")
        let searchResultsVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultsViewController")
        let userVC = self.storyboard?.instantiateViewController(withIdentifier: "UserViewController")
        MainController.homeViewController = (homeVC as! HomeViewController)
        MainController.featuredViewController = (featuredVC as! FeaturedViewController)
        MainController.searchResultsViewController = (searchResultsVC as! SearchResultsViewController)
        MainController.userViewController = (userVC as! UserViewController)
        
        viewControllers = [homeVC, featuredVC, searchResultsVC, userVC]
        for vc in viewControllers {
            self.addChild(vc!)
            vc!.didMove(toParent: self)
            vc!.view.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 80)
            self.views.append(vc!.view)
        }
        self.collectionView.reloadData()
        
        //NotificationCenter setup
        NotificationCenter.default.addObserver(self, selector: #selector(self.scrollViews(notification:)), name: Notification.Name.init(rawValue: "didSelectMenu"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideBar(notification:)), name: NSNotification.Name("hide"), object: nil)
    }
    
    /// Scroll the menu, this will be called when a notification is being sent with value **didSelectMenu**
    @objc func scrollViews(notification: Notification) {
        if let info = notification.userInfo {
            let userInfo = info as! [String: Int]
            self.collectionView.scrollToItem(at: IndexPath.init(row: userInfo["index"]!, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    /// Hide the navigation bar,  this will be called when a notification is being sent with value **hide**
    @objc func hideBar(notification: NSNotification)  {
        let state = notification.object as! Bool
        self.navigationController?.setNavigationBarHidden(state, animated: true)
    }
    
    //MARK: - Delegates
    /**
     Asks collectionView for the number of items in the specified section.
     
     - Parameters:
        - collectionView: The collection view requesting this information.
        - section: An index number identifying a section in collectionView. This index value is 0-based.
     - returns:
     The number of rows in section.
     
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.views.count
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
        cell.contentView.addSubview(self.views[indexPath.row])
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.collectionView.bounds.width, height: (self.collectionView.bounds.height + 22))
    }
    
    
    /**
     Tells the delegate when the user scrolls the content view within the receiver.
     
     - Parameters:
        - scorllView: The scroll-view object in which the scrolling occurred.
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollIndex = scrollView.contentOffset.x / self.view.bounds.width
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "scrollMenu"), object: nil, userInfo: ["length": scrollIndex])
    }
    
    //MARK: - ViewController lifecycle
    /**
     Called after the controller's view is loaded into memory. Load  `customisation`
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customisation()
    }
    
    /// Deinitialization Function
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
