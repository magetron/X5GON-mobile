//
//  LoginView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 09/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit
import Foundation
import SwiftSoup

class LoginView: UIView {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    func customisation () {
        self.passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let username = self.usernameTextField.text else {
            return
        }
        guard let password = self.passwordTextField.text else {
            return
        }
        let loginSuccess = MainController.login(username: username, password: password)
        if (loginSuccess) {
            self.hideLoginView()
        }
    }
    
    func hideLoginView() {
        UIView.animate(withDuration: 0.6) {
            self.center.y -= self.bounds.height
            self.layoutIfNeeded()
        }
        self.center.y += self.bounds.height
        self.isHidden = true
    }
    
    override func awakeFromNib () {
        super.awakeFromNib()
        self.customisation()
    }
}
