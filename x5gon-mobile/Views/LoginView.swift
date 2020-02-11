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

    func customization () {
        self.passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let username = self.usernameTextField.text else {
            // login view exit
            return
        }
        guard let password = self.passwordTextField.text else {
            // login view exit
            return
        }
        // login

    }
    
    override func awakeFromNib () {
        super.awakeFromNib()
        self.customization()
    }
}
