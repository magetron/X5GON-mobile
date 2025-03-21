//
//  SubscriptionViewController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit
/// This a controller to control search results
class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    // MARK: - Properties

    /// This is a `UItableView` which is used to display `Content`s as cells
    @IBOutlet var tableView: UITableView!
    /// This variable is used to store a list of self-defined type `Content`
    var contents = [Content]()
    /// This is the offset of the last Content used to determine the scroll action
    var lastContentOffset: CGFloat = 0.0

    // MARK: - Methods

    /// Customise `tableView`
    func customisation() {
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 30, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 30, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }

    // MARK: - Delegates

    /**
     Tells list of `Content`s to return the number of rows in a given section of a table view.

     - Parameters:
        - tableView: The table-view object requesting this information.
        - indexPath: An index number identifying a section in tableView.
     - returns:
     The number of rows in section.

     */
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return contents.count == 0 ? 1 : contents.count
    }

    /**
     Asks the list of `Centent`s for a cell to insert in a particular location of the table view.

     - Parameters:
        - tableView: A table-view object requesting the cell.
        - indexPath: An index path locating a row in tableView.
     - returns:
     An object inheriting from `UITableViewCel`l that the table view can use for the specified row. `UIKit` raises an assertion if you return nil.

     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if contents.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell") as! ContentCell
            cell.set(content: contents[indexPath.row])
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell.textLabel?.text = "⚠️ Search and come back here to see results!"
            return cell
        }
    }

    /**
     Tells the delegate that the specified row is now selected. And send **open**  notification

     - Parameters:
        - tableView: A table-view object informing the delegate about the new row selection.
        - indexPath: An index path locating the new selected row in tableView.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if contents.count != 0 {
            NotificationCenter.default.post(name: NSNotification.Name("open"), object: contents[indexPath.row])
            tableView.deselectRow(at: indexPath, animated: true)
        }
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
     }
     */

    // MARK: -  ViewController Lifecycle

    /// Called after the controller's view is loaded into memory. Load `customisation` method
    override func viewDidLoad() {
        super.viewDidLoad()
        customisation()
    }
}
