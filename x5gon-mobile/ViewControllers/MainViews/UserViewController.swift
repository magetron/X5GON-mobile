//
//  UserViewController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties
    ///This is a `UITableView` that displays user information
    @IBOutlet weak var tableView: UITableView!
    ///This is a self-defined view called `UserHistoryView`, which is based on `UIView`
    @IBOutlet var historyView: UserHistoryView!
    /// This is a list of menu titles that is displayed in `UITableView`
    let menuTitles = ["History", "My Videos", "Watch Later", "Logout", "Bookmarks:"]
    /// Default number of items = 6, including user title
    let defaultItems = 6
    /// User information
    var user = MainController.user
    /// The offset of the last Content used to determine the scroll action
    var lastContentOffset: CGFloat = 0.0
    
    //MARK: - Methods

    /**
     ### Customise View ###
     - Setup `HistoryView`
     - Setup `TableView`
     */
    func customisation() {
        guard let v = self.view else { return }
        
        self.view.addSubview(historyView)
        self.historyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: v, attribute: .top, relatedBy: .equal, toItem: self.historyView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: v, attribute: .left, relatedBy: .equal, toItem: self.historyView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: v, attribute: .right, relatedBy: .equal, toItem: self.historyView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: v, attribute: .bottom, relatedBy: .equal, toItem: self.historyView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        self.historyView.isHidden = true
        self.historyView.historyContent = user.historyContent
        
        self.tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 30, right: 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 30, right: 0)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 300
        self.tableView.reloadDataWithAnimation()
    }
    
    ///Show History View
    func showHistory () {
        self.historyView.historyContent = user.historyContent
        self.historyView.tableView.reloadDataWithAnimation()
        self.historyView.isHidden = false
        self.historyView.center.x += self.historyView.bounds.width;
        UIView.animate(withDuration: 0.3) {
            self.historyView.center.x -= self.historyView.bounds.width
        }
    }
    
    /// Set User for view
    func setUser (user: User) {
        self.user = user
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.defaultItems + self.user.bookmarkedContent.count
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
            cell.name.text = self.user.name
            cell.profilePic.image = self.user.profilePic
            cell.backgroundImage.image = self.user.backgroundImage
            return cell
        case 1...self.defaultItems - 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserMenuCell", for: indexPath) as! userMenuCell
            cell.menuTitles.text = self.menuTitles[indexPath.row - 1]
            cell.menuIcon.image = UIImage.init(named: self.menuTitles[indexPath.row - 1])
           return cell
        case self.defaultItems - 1:
            let cell = UITableViewCell()
            cell.textLabel?.text = "Bookmarks :"
            return cell
        case self.defaultItems...(self.defaultItems + self.user.bookmarkedContent.count):
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserPlaylistsCell", for: indexPath) as! userPlaylistCell
            cell.pic.image = self.user.bookmarkedContent[self.user.bookmarkedContent.index(self.user.bookmarkedContent.startIndex, offsetBy: indexPath.row - self.defaultItems)].thumbnail
            cell.title.text = self.user.bookmarkedContent[self.user.bookmarkedContent.index(self.user.bookmarkedContent.startIndex, offsetBy: indexPath.row - self.defaultItems)].title
            cell.channel.text = self.user.bookmarkedContent[self.user.bookmarkedContent.index(self.user.bookmarkedContent.startIndex, offsetBy: indexPath.row - self.defaultItems)].channel.name
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
        if (indexPath.row == 0) {
            return
        } else if (indexPath.row < self.defaultItems) {
            if (menuTitles[indexPath.row - 1] == "History") {
                showHistory()
            } else if (menuTitles[indexPath.row - 1] == "Logout") {
                MainController.logout();
                let alert = UIAlertController(title: "Logout Successful", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated:  true, completion: nil)
                user = MainController.user
                self.tableView.reloadDataWithAnimation()
            }
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("open"), object: self.user.bookmarkedContent[self.user.bookmarkedContent.index(self.user.bookmarkedContent.startIndex, offsetBy: indexPath.row - self.defaultItems)])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }


    
    
    //MARK: - ViewController Lifecycle
    /**
     Called after the controller's view is loaded into memory. Load  `customisation`
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customisation()
    }
}




