//
//  SearchView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class SearchView: UIView, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var inputField: UITextField!
    var suggestions = [String]()
    
    //MARK: Methods
    func customisation() {
        self.inputField.delegate = self
    }
    
    @IBAction func hideSearchView(_ sender: Any) {
        self.inputField.text = ""
        self.inputField.resignFirstResponder()
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { _ in
            self.isHidden = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        refresher(updateContent: {() -> Void in
            let result = MainController.search(keyword: text, contentType: "any")
            MainController.homeViewController?.updateContents(newContents: result)
        }, viewReload: {() -> Void in MainController.homeViewController?.tableView.reloadData()})
        self.hideSearchView(self)
        return true
    }
    
    //MARK: View LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customisation()
    }
}

