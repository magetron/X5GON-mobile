//
//  UserViewController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

/// `UserViewController` is used to control the user page view
class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Properties

    /// This is a `UITableView` that displays user information
    @IBOutlet var tableView: UITableView!
    /// This is a self-defined view called `UserHistoryView`, which is based on `UIView`
    @IBOutlet var historyView: UserHistoryView!
    /// This is a list of menu titles that is displayed in `UITableView`
    let menuTitles = ["History", "My Videos", "Watch Later", "Logout", "Bookmarks:"]
    /// Default number of items = 6, including user title
    let defaultItems = 6
    /// User information
    var user = MainController.user
    /// The offset of the last Content used to determine the scroll action
    var lastContentOffset: CGFloat = 0.0
    /// Control the refresh process
    var refreshControl = UIRefreshControl()

    // MARK: - Methods

    /**
     ### Customise View ###
     - Setup `HistoryView`
     - Setup `TableView`
     */
    func customisation() {
        guard let v = view else { return }

        view.addSubview(historyView)
        historyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: historyView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: historyView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: v, attribute: .right, relatedBy: .equal, toItem: historyView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: v, attribute: .bottom, relatedBy: .equal, toItem: historyView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        historyView.isHidden = true
        historyView.historyContent = user.historyContent

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 30, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 30, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.reloadDataWithAnimation()
        NotificationCenter.default.addObserver(self, selector: #selector(scrollViews(notification:)), name: Notification.Name(rawValue: "didSelectMenu"), object: nil)
    }

    /// Scroll the menu, this will be called when a notification is being sent with value **didSelectMenu**
    @objc func scrollViews(notification: Notification) {
        if let info = notification.userInfo {
            let userInfo = info as! [String: Int]
            if userInfo["index"] == 3 {
                historyView.hideHistoryView(self)
            }
        }
    }

    /// Show History View
    func showHistory() {
        historyView.historyContent = user.historyContent
        historyView.tableView.reloadDataWithAnimation()
        historyView.isHidden = false
        historyView.center.x += historyView.bounds.width
        UIView.animate(withDuration: 0.3) {
            self.historyView.center.x -= self.historyView.bounds.width
        }
    }

    /// Set User for view
    func setUser(user: User) {
        self.user = user
    }

    /// Refresh the page, when a notification is being sent with value **refresh**
    @objc func refresh(sender _: Any) {
        refresherWithLoadingHUD(updateContent: {}, viewReload: { () -> Void in self.tableView.reloadDataWithAnimation() }, view: tableView, cancellable: false)
        refreshControl.endRefreshing()
    }

    // MARK: Delegates

    /**
     Tells the data source to return the number of rows in a given section of a table view.

     - Parameters:
        - tableView: The table-view object requesting this information.
        - indexPath: An index number identifying a section in tableView.
     - returns:
     The number of rows in section.

     */
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return defaultItems + user.bookmarkedContent.count
    }

    /**
     Asks the source for a cell to insert in a particular location of the table view.

     - Parameters:
        - tableView: A table-view object requesting the cell.
        - indexPath: An index path locating a row in tableView.
     - returns:
     An object inheriting from `UITableViewCel`l that the table view can use for the specified row. `UIKit` raises an assertion if you return nil.

     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserHeaderCell", for: indexPath) as! userHeaderCell
            cell.name.text = user.name
            cell.profilePic.image = user.profilePic
            cell.backgroundImage.image = user.backgroundImage
            return cell
        case 1 ... defaultItems - 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserMenuCell", for: indexPath) as! userMenuCell
            cell.menuTitles.text = menuTitles[indexPath.row - 1]
            cell.menuIcon.image = UIImage(named: menuTitles[indexPath.row - 1])
            return cell
        case defaultItems - 1:
            let cell = UITableViewCell()
            cell.textLabel?.text = "Bookmarks :"
            return cell
        case defaultItems ... (defaultItems + user.bookmarkedContent.count):
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserPlaylistsCell", for: indexPath) as! userPlaylistCell
            cell.pic.image = user.bookmarkedContent[user.bookmarkedContent.index(user.bookmarkedContent.startIndex, offsetBy: indexPath.row - defaultItems)].thumbnail
            cell.title.text = user.bookmarkedContent[user.bookmarkedContent.index(user.bookmarkedContent.startIndex, offsetBy: indexPath.row - defaultItems)].title
            cell.channel.text = user.bookmarkedContent[user.bookmarkedContent.index(user.bookmarkedContent.startIndex, offsetBy: indexPath.row - defaultItems)].channel.name
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserMenuCell", for: indexPath) as! userMenuCell
            return cell
        }
    }

    /**
     Tells the delegate that the specified row is now selected.

     - Parameters:
        - tableView: A table-view object informing the delegate about the new row selection.
        - indexPath: An index path locating the new selected row in tableView.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            return
        } else if indexPath.row < defaultItems {
            if menuTitles[indexPath.row - 1] == "History" {
                showHistory()
            } else if menuTitles[indexPath.row - 1] == "Logout" {
                MainController.logout()
                let alert = UIAlertController(title: "Logout Successful", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(alert, animated: true, completion: nil)
                user = MainController.user
                self.tableView.reloadDataWithAnimation()
            }
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("open"), object: user.bookmarkedContent[user.bookmarkedContent.index(user.bookmarkedContent.startIndex, offsetBy: indexPath.row - defaultItems)])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - ViewController Lifecycle

    /**
     Called after the controller's view is loaded into memory. Load  `customisation`
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        customisation()
    }
}
