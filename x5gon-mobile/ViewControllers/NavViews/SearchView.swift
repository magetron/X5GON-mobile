//
//  SearchView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class SearchView: UIView, UITextFieldDelegate {
    // MARK: - Properties

    @IBOutlet var inputField: UITextField!
    var suggestions = [String]()

    // MARK: - Methods

    func customisation() {
        inputField.delegate = self
    }

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

    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
}
