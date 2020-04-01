//
//  SearchView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

/// The view for search Bar
class SearchView: UIView, UITextFieldDelegate {
    // MARK: - Properties

    /// This is a `UItextField` used to input the search content
    @IBOutlet var inputField: UITextField!
    var suggestions = [String]()

    // MARK: - Methods

    /// Cusomise the view
    func customisation() {
        inputField.delegate = self
    }

    /// HIde search View
    @IBAction func hideSearchView(_: Any) {
        inputField.text = ""
        inputField.resignFirstResponder()
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { _ in
            self.isHidden = true
        }
    }

    // MARK: - Delegate

    /**
     Asks the delegate if the text field should process the pressing of the return button.

     - Parameters:
        - textField: The text field whose return button was pressed.

     - returns:
     `true` if the text field should implement its default behavior for the return button; otherwise, `false`.

     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        refresherWithLoadingHUD(updateContent: { () -> Void in
            let result = MainController.search(keyword: text, contentType: "any", cancellable: false)
            MainController.searchResultsViewController?.contents = result
        }, viewReload: { () -> Void in MainController.searchResultsViewController?.tableView.reloadDataWithAnimation() }, view: (MainController.searchResultsViewController?.tableView)!, cancellable: false)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "didSelectMenu"), object: nil, userInfo: ["index": 2])
        hideSearchView(self)
        return true
    }

    // MARK: - View LifeCycle

    /// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
}
