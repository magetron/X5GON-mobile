//
//  SettingsView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

protocol SettingsViewControllerDelegate {
    func showLogin () -> Void
}


class SettingsView: UIView, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundView: UIButton!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    var delegate:SettingsViewControllerDelegate?
    let items = ["Settings", "Terms & privacy policy", "Send Feedback", "Help", "Login", "Cancel"]
    var showLogin: (() -> Void) = { () in return }
    
    //MARK: - Methods
    func customisation() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.backgroundView.alpha = 0
        self.tableViewBottomConstraint.constant = -self.tableView.bounds.height
        self.tableView.roundCorners([.topLeft, .topRight], radius: 20)
        self.layoutIfNeeded()
    }
    
    @IBAction func hideSettingsView(_ sender: Any) {
        self.tableViewBottomConstraint.constant = -self.tableView.bounds.height
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            self.isHidden = true
        }
    }
    
    //MARK: - Delegates
    /**
     Tells the items to return the number of rows in a given section of a table view.
     
     - Parameters:
        - tableView: The table-view object requesting this information.
        - indexPath: An index number identifying a section in tableView.
     - returns:
     The number of rows in section.
     
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
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
        cell.textLabel?.text = self.items[indexPath.row]
        cell.imageView?.image = UIImage.init(named: self.items[indexPath.row])
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
        self.hideSettingsView(self)
        if (self.items[indexPath.row] == "Login") {
            self.delegate?.showLogin()
        } else if (self.items[indexPath.row] == "Terms & privacy policy") {
            guard let url = URL(string: "https://patrickwu.uk/X5GON-mobile/LICENSE") else { return }
            let vc = SFSafariViewController(url: url)
            self.parentViewController?.present(vc, animated: true, completion: nil)
        } else if (self.items[indexPath.row] == "Help") {
            guard let url = URL(string: "http://students.cs.ucl.ac.uk/2019/group4/") else { return }
            let vc = SFSafariViewController(url: url)
            self.parentViewController?.present(vc, animated: true, completion: nil)
        } else if (self.items[indexPath.row] == "Send Feedback") {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["patrick.wu.17@ucl.ac.uk"])
                mail.setSubject("Feedback on X5GON App")
                mail.setMessageBody("<p>Device UUID: \(UIDevice.current.identifierForVendor!.uuidString)</p>", isHTML: true)
                self.parentViewController!.present(mail, animated: true)
            } else {
                let alert = UIAlertController(title: "This Device doesn't support sending Mail", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.parentViewController!.present(alert, animated:  true, completion: nil)
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    //MARK: - View LifeCycle
    /**
     Called after the controller's view is loaded into memory. Load  `customisation`
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customisation()
    }
}

