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
    @IBOutlet weak var backgroundView: UIButton!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var view: UIView!
    
    //MARK: - Methods
    
    ///Customise the LoginView
    func customisation () {
        self.passwordTextField.isSecureTextEntry = true
        self.isUserInteractionEnabled = true
        /*let swipeToExit = UISwipeGestureRecognizer(target: self, action: #selector(self.hideLoginView))
        swipeToExit.direction = .down
        self.addGestureRecognizer(swipeToExit)*/
        self.backgroundView.alpha = 0
        self.view.roundCorners([.topLeft, .topRight], radius: 20)
        self.viewBottomConstraint.constant = -self.view.bounds.height
        self.layoutIfNeeded()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardSize.height)
            UIView.animate(withDuration: 0.3, animations: {
                self.viewBottomConstraint.constant = keyboardSize.height
            })
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3, animations: {
                self.viewBottomConstraint.constant = 0
            })
        }
    }
    
    /// Perform when the login Button is pressed
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.endEditing(true)
        guard let username = self.usernameTextField.text else {
            return
        }
        guard let password = self.passwordTextField.text else {
            return
        }
        let loginSuccess = MainController.login(username: username, password: password)
        if (loginSuccess) {
            self.hideLoginView(self)
            NotificationCenter.default.post(name: Notification.Name.init(rawValue: "didSelectMenu"), object: nil, userInfo: ["index": 3])
        } else {
            let alert = UIAlertController(title: "Login Failed", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            MainController.navViewController!.present(alert, animated: true, completion: nil)
        }
    }
    /// This function will hide `LoginView` when it is being called
    @IBAction func hideLoginView(_ sender: Any) {
        self.endEditing(true)
        self.viewBottomConstraint.constant = -self.view.bounds.height
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            self.isHidden = true
        }
        /*UIView.animate(withDuration: 0.6, animations: {
            self.transform = CGAffineTransform.init(translationX: 0, y: self.bounds.height)
            self.layoutIfNeeded()
        }) { (isSuccessful) in
            self.isHidden = true
            self.transform = .identity
        }*/
    }
        
    //MARK: - View Lifecycle
    /// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file. Load `customisation` function
    override func awakeFromNib () {
        super.awakeFromNib()
        self.customisation()
    }
}
