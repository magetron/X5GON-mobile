//
//  SettingsView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import MessageUI
import SafariServices
import UIKit

/// The protocol for setting view
protocol SettingsViewControllerDelegate {
    func showLogin() -> Void
}

/// This a Setting View
class SettingsView: UIView, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    // MARK: - Properties

    /// This is a `tableView` to display the setting contents as cell
    @IBOutlet var tableView: UITableView!
    /// This is background View
    @IBOutlet var backgroundView: UIButton!
    /// This is a `NSLayoutConstraint` for the bottom constraint
    @IBOutlet var tableViewBottomConstraint: NSLayoutConstraint!
    /// This is a variable for delegates
    var delegate: SettingsViewControllerDelegate?
    /// The items on setting view
    let items = ["Settings", "Terms & privacy policy", "Send Feedback", "Help", "Login", "Cancel"]
    /// Show Login
    var showLogin: (() -> Void) = { () in }

    // MARK: - Methods

    /// Customise the view
    func customisation() {
        // tableViewWidthConstraint.constant = UIScreen.main.bounds.width
        tableView.frame.size.width = UIScreen.main.bounds.width
        tableView.delegate = self
        tableView.dataSource = self
        backgroundView.alpha = 0
        tableViewBottomConstraint.constant = -tableView.bounds.height
        tableView.roundCorners([.topLeft, .topRight], radius: 20)
        layoutIfNeeded()
    }

    /// Hide setting View
    @IBAction func hideSettingsView(_: Any) {
        tableViewBottomConstraint.constant = -tableView.bounds.height
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            self.isHidden = true
        }
    }

    // MARK: - Delegates

    /**
     Tells the items to return the number of rows in a given section of a table view.

     - Parameters:
        - tableView: The table-view object requesting this information.
        - indexPath: An index number identifying a section in tableView.
     - returns:
     The number of rows in section.

     */
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return items.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.imageView?.image = UIImage(named: items[indexPath.row])?.adaptToDarkMode()
        return cell
    }

    /**
     Tells the delegate that the specified row is now selected.

     - Parameters:
        - tableView: A table-view object informing the delegate about the new row selection.
        - indexPath: An index path locating the new selected row in tableView.
     */

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        hideSettingsView(self)
        if items[indexPath.row] == "Login" {
            delegate?.showLogin()
        } else if items[indexPath.row] == "Terms & privacy policy" {
            let viewController = UIViewController()
            let textView = UITextView(frame: viewController.view.frame)
            textView.font = UIFont.systemFont(ofSize: 10)
            textView.text = Environment.loadLICENSE()
            viewController.view.addSubview(textView)
            parentViewController?.present(viewController, animated: true)
        } else if items[indexPath.row] == "Help" {
            guard let url = URL(string: "https://patrickwu.uk/X5GON-mobile/user-manual/user-manual") else { return }
            let vc = SFSafariViewController(url: url)
            parentViewController?.present(vc, animated: true, completion: nil)
        } else if items[indexPath.row] == "Send Feedback" {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["patrick.wu.17@ucl.ac.uk"])
                mail.setSubject("Feedback on X5GON App")
                mail.setMessageBody("<p>Device UUID: \(UIDevice.current.identifierForVendor!.uuidString)</p>", isHTML: true)
                parentViewController!.present(mail, animated: true)
            } else {
                let alert = UIAlertController(title: "This Device doesn't support sending Mail", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                parentViewController!.present(alert, animated: true, completion: nil)
            }
        }
    }

    /**
     Tells the delegate that the user wants to dismiss the mail composition view.

     - Parameters:
        - controller: The view controller object that manages the mail composition view.
        - didFinishWith: The result of the user’s action.
        - error: If an error occurred, this parameter contains an error object with information about the type of failure.
     */
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith _: MFMailComposeResult, error _: Error?) {
        controller.dismiss(animated: true)
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
