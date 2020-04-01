//
//  LoginView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 09/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    // MARK: - Properties

    /// This is a `UITextField` which is used to input username
    @IBOutlet var usernameTextField: UITextField!
    // This is a `UITextField` which is used to input password
    @IBOutlet var passwordTextField: UITextField!
    /// This is a `UIButton` which is used to press for logiin
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var backgroundView: UIButton!
    @IBOutlet var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var personIcon: UIImageView!
    @IBOutlet var lockIcon: UIImageView!
    @IBOutlet var view: UIView!

    // MARK: - Methods

    /// Customise the LoginView
    func customisation() {
        view.frame.size.width = UIScreen.main.bounds.width
        view.roundCorners([.topLeft, .topRight], radius: 20)
        viewBottomConstraint.constant = -view.bounds.height
        layoutIfNeeded()

        usernameTextField.center.x = UIScreen.main.bounds.width / 2
        passwordTextField.center.x = UIScreen.main.bounds.width / 2
        loginButton.center.x = UIScreen.main.bounds.width / 2
        personIcon.center.x = UIScreen.main.bounds.width / 2 - usernameTextField.frame.size.width / 2 - personIcon.frame.size.width / 2
        lockIcon.center.x = UIScreen.main.bounds.width / 2 - usernameTextField.frame.size.width / 2 - lockIcon.frame.size.width / 2

        passwordTextField.isSecureTextEntry = true
        isUserInteractionEnabled = true
        /* let swipeToExit = UISwipeGestureRecognizer(target: self, action: #selector(self.hideLoginView))
         swipeToExit.direction = .down
         self.addGestureRecognizer(swipeToExit) */
        backgroundView.alpha = 0

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
    @IBAction func loginButtonPressed(_: Any) {
        endEditing(true)
        guard let username = usernameTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        let loginSuccess = MainController.login(username: username, password: password)
        if loginSuccess {
            hideLoginView(self)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "didSelectMenu"), object: nil, userInfo: ["index": 3])
        } else {
            let alert = UIAlertController(title: "Login Failed", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            MainController.navViewController!.present(alert, animated: true, completion: nil)
        }
    }

    /// This function will hide `LoginView` when it is being called
    @IBAction func hideLoginView(_: Any) {
        endEditing(true)
        viewBottomConstraint.constant = -view.bounds.height
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            self.isHidden = true
        }
        /* UIView.animate(withDuration: 0.6, animations: {
             self.transform = CGAffineTransform.init(translationX: 0, y: self.bounds.height)
             self.layoutIfNeeded()
         }) { (isSuccessful) in
             self.isHidden = true
             self.transform = .identity
         } */
    }

    // MARK: - View Lifecycle

    /// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file. Load `customisation` function
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
}
