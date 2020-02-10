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
    var csrfToken = ""

    func customization () {
        queryCSRFToken()
        self.passwordTextField.isSecureTextEntry = true
    }
    
    func queryCSRFToken () {
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: URL.init(string: Environment.X5URL + "login")!) {(data, response, error) in
            defer { semaphore.signal() }
            guard let data = data else { return }
            do {
                let divFields: Elements = try SwiftSoup.parse(String(decoding: data, as: UTF8.self)).body()!.select("div")
                let centreDiv = divFields.array()[1]
                let inputFields = try centreDiv.select("form").first()!.select("input")
                for inputField in inputFields {
                    if inputField.id() == "csrf_token" {
                        self.csrfToken = try inputField.val()
                    }
                }
            } catch {
                print("error: cannot fetch csrf token")
            }
        }
        task.resume()
        semaphore.wait()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let username = self.usernameTextField.text
        let password = self.passwordTextField.text
        
        
        
    }
    
    override func awakeFromNib () {
        super.awakeFromNib()
        self.customization()
    }
}
