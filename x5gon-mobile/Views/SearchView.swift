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
    func customization() {
        self.inputField.delegate = self
    }
    
    @IBAction func hideSearchView(_ sender: Any) {
        self.inputField.text = ""
        self.suggestions.removeAll()
        self.inputField.resignFirstResponder()
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { _ in
            self.isHidden = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let searchResult = VideoController.fetchItems(keyWord: textField.text ?? "", contentType: "video") + PDFController.fetchItems(keyWord: textField.text ?? "", contentType: "text")
        print(self.parentViewController is NavViewController)
        let navViewController = self.parentViewController as! HomeViewController

        self.hideSearchView(self)
        return true
    }
    
    //MARK: View LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customization()
    }
}

class SearchCell: UITableViewCell {
    @IBOutlet weak var resultLabel: UILabel!
}

