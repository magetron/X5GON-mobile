//
//  playerNavigationView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 23/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

/// This is a side bar view for `Wiki`s
class playerNavigationView: UIView, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Properties

    /// The background View
    @IBOutlet var backgroundView: UIButton!
    /// This is a `UITableView` to  hold the `Wiki` as cells
    @IBOutlet var tableView: UITableView!
    /// Self defined type `Wiki`
    var wiki: Wiki?
    /// Table View Content
    var tableViewContent = [String]()

    // MARK: - Methods

    /// Customise the cell
    func customisation() {
        tableView.delegate = self
        tableView.dataSource = self
        backgroundView.alpha = 0
        layoutIfNeeded()
    }

    /// Hide the side bar
    @IBAction func hideNavigationView(_: Any) {
        UIView.animate(withDuration: 0.6, animations: {
            self.tableView.transform = CGAffineTransform(translationX: self.bounds.width, y: 0)
            self.backgroundView.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            self.isHidden = true
            self.tableView.transform = .identity
        }
    }

    /// Set `Wiki`s
    func setWiki(wiki: Wiki) {
        self.wiki = wiki
        tableViewContent.removeAll()
        var chunkNum = 1
        for chunk in self.wiki!.chunks {
            var entityNum = 1
            for entity in chunk.entities {
                tableViewContent.append("\(chunkNum).\(entityNum) \(entity.title)")
                entityNum += 1
            }
            chunkNum += 1
        }
    }

    // MARK: - Delegates

    /**
     Tells the list of `Wiki`s to return the number of rows in a given section of a table view.

     - Parameters:
        - tableView: The table-view object requesting this information.
        - indexPath: An index number identifying a section in tableView.
     - returns:
     The number of rows in section.

     */
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return tableViewContent.count == 0 ? 1 : tableViewContent.count
    }

    /**
     Asks the list of `Wiki` for a cell to insert in a particular location of the table view.

     - Parameters:
        - tableView: A table-view object requesting the cell.
        - indexPath: An index path locating a row in tableView.
     - returns:
     An object inheriting from `UITableViewCel`l that the table view can use for the specified row. `UIKit` raises an assertion if you return nil.

     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableViewContent.count == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "⚠️ Topics unavailable"
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerNavigationCell")!
        cell.textLabel?.text = tableViewContent[indexPath.row]
        return cell
    }

    // MARK: - View Lifecycle

    /// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
}
