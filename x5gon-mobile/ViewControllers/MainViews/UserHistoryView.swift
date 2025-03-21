//
//  UserHistoryTableView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 28/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit
/// User History View set up
class UserHistoryView: UIView, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate {
    // MARK: - Properties

    /// This is a list of `Content`s which is used to store history contents
    var historyContent = [Content]()
    /// The `Back` button
    @IBOutlet var backButton: UIButton!
    /// Connenct to UInavigationBar
    @IBOutlet var navBar: UINavigationBar!
    // This is a `UITableView` which is used to display `Content`s as cells.
    @IBOutlet var tableView: UITableView!

    // MARK: - Methods

    /**
     ### Customise View ###
     - Setup TableView
     */
    func customisation() {
        addSubview(navBar)
        addSubview(backButton)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = 100
        addSubview(tableView)

        bringSubviewToFront(navBar)
        bringSubviewToFront(backButton)
    }

    /// This will hide the historyview when a notification value **true** is being sent
    @IBAction func hideHistoryView(_: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(translationX: self.bounds.width, y: 0)
            self.layoutIfNeeded()
        }) { _ in
            self.isHidden = true
            self.transform = .identity
        }
    }

    // MARK: - Delegate

    /**
     Tells the list of history `Content`s to return the number of rows in a given section of a table view.

     - Parameters:
        - tableView: The table-view object requesting this information.
        - indexPath: An index number identifying a section in tableView.
     - returns:
     The number of rows in section.

     */
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return historyContent.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserHistoryViewCell") as! userHistoryViewCell
        let content = historyContent[indexPath.row]
        cell.set(thumbnail: content.thumbnail, title: content.title, channel: content.channel.name)
        return cell
    }

    /**
     Tells the delegate that the specified row is now selected. And send **open**  notification

     - Parameters:
        - tableView: A table-view object informing the delegate about the new row selection.
        - indexPath: An index path locating the new selected row in tableView.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("open"), object: historyContent[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - View LifeCycle

    /**
     Called after the controller's view is loaded into memory. Load  `customisation`
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
}
