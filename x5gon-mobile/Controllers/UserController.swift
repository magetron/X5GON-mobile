//
//  UserController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 10/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import SwiftSoup

class UserController {
    static var csrfToken = ""
    static var authenticationToken = ""

    private static func queryCSRFToken () {
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

    static func getCSRFToken () -> String {
        if (authenticationToken != "") {
            return authenticationToken
        }
        if (csrfToken == "") {
            queryCSRFToken()
        }
        return self.csrfToken
    }
    
    static func logOut () {
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: URL.init(string: Environment.X5URL + "logout")!) {(data, response, error) in
            defer { semaphore.signal() }
            guard data != nil else { return }
        }
        task.resume()
        semaphore.wait()
    }
    
    static func loginWith (username: String, password: String, csrfToken: String) {
        logOut()
        var request = URLRequest(url: URL(string: Environment.X5URL + "login")!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "email": username,
            "password": password,
            "csrf_token": csrfToken
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("error: \(error.localizedDescription)")
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            defer { semaphore.signal() }
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
                else {
                    print("error: not a valid http response")
                    return
                }
            if (httpResponse.statusCode != 200) {
                print("error: http response \(httpResponse.statusCode) not successful")
            } else {
                let jsonObject = try? JSONSerialization.jsonObject(with: receivedData, options: [])
                guard let json = jsonObject as? [String: Any] else {
                    print("error: invalid format")
                    return
                }
                guard let response = json["response"] as? [String: Any] else {
                    print("error: invalid format")
                    return
                }
                guard let userInfo = response["user"] as? [String: Any] else {
                    print("error: invalid format")
                    return
                }
                let authToken = userInfo["authentication_token"] as! String
                self.authenticationToken = authToken
             }
        }

        task.resume()
        semaphore.wait()
        print(authenticationToken)
    }
}
