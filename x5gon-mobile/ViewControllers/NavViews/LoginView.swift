//
//  LoginView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 09/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit
import Foundation


class LoginView: UIView {
    //MARK: - Properties
    ///This is a `UITextField` which is used to input username
    @IBOutlet weak var usernameTextField: UITextField!
    //This is a `UITextField` which is used to input password
    @IBOutlet weak var passwordTextField: UITextField!
    ///This is a `UIButton` which is used to press for logiin
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - Methods
    
    ///Customise the LoginView
    func customisation () {
        self.passwordTextField.isSecureTextEntry = true
        self.isUserInteractionEnabled = true
        let swipeToExit = UISwipeGestureRecognizer(target: self, action: #selector(self.hideLoginView))
        swipeToExit.direction = .down
        self.addGestureRecognizer(swipeToExit)
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
    
    @objc func hideLoginView() {
        UIView.animate(withDuration: 0.6, animations: {
            self.transform = CGAffineTransform.init(translationX: 0, y: self.bounds.height - 90)
            self.layoutIfNeeded()
        }) { (isSuccessful) in
            self.isHidden = true
            self.transform = .identity
            self.center.y -= 90
        }
    }
    
    //MARK: - View Lifecycle
    /// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file. Load `customisation` function
    override func awakeFromNib () {
        super.awakeFromNib()
        self.customisation()
    }
}
