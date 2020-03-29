//
//  HomeViewController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    //MARK: - Properties
    ///This is a `UITableView` used to display `Content` as cells
    @IBOutlet weak var tableView: UITableView!
    /// This is a variable to store list of `Contents`
    var contents = [Content]()
    /// This is the offset of the last Content used to determine the scroll action
    var lastContentOffset: CGFloat = 0.0
    
    //MARK: - Methods
        /**
     ### Customise View ###
     - Setup `tableView`
     */
    func customisation() {
        self.tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 300
        refresherWithLoadingHUD(updateContent: {() -> Void in self.contents =
            MainController.fetchDefaultContents(cancellable: false)}, viewReload: {() -> Void in self.tableView.reloadDataWithAnimation()}, view: self.tableView, cancellable: false)
    }
    
    
    //MARK: - Delegates
    /**
     Tells the list of `Content`s to return the number of rows in a given section of a table view.
     
     - Parameters:
        - tableView: The table-view object requesting this information.
        - indexPath: An index number identifying a section in tableView.
     - returns:
     The number of rows in section.
     
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contents.count
    }
    
    /**
     Asks the list of `Centent` for a cell to insert in a particular location of the table view.
     
     - Parameters:
        - tableView: A table-view object requesting the cell.
        - indexPath: An index path locating a row in tableView.
     - returns:
     An object inheriting from `UITableViewCel`l that the table view can use for the specified row. `UIKit` raises an assertion if you return nil.
     
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell") as! ContentCell
        cell.set(content: self.contents[indexPath.row])
        return cell
    }
    
    
    /**
     Tells the delegate that the specified row is now selected. And send **open**  notification
     
     - Parameters:
        - tableView: A table-view object informing the delegate about the new row selection.
        - indexPath: An index path locating the new selected row in tableView.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("open"), object: contents[indexPath.row])
    }
    
    /*
    /**
     Tells the delegate when the user scrolls the content view within the receiver. Send the **hide** notification
     
     - Parameters:
        - scorllView: The scroll-view object in which the scrolling occurred.
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: false)
        } else if(self.lastContentOffset < scrollView.contentOffset.y){
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: true)
        }
    }

    /**
     Tells the delegate when dragging ended in the scroll view.  Update the last Content Offset
     
     - Parameters:
        - scrollView: The scrollVview object that finished scrolling the content view.
        - decelerate: The value is true if the scrolling movement will continue, but decelerate, after a touch-up gesture during a dragging operation. If the value is false, scrolling stops immediately upon touch-up.
     */
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.lastContentOffset = scrollView.contentOffset.y;
    }*/
    
    //MARK: - ViewController Lifecylce
    ///Called after the controller's view is loaded into memory. Load `customisation` method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customisation()
    }
}
