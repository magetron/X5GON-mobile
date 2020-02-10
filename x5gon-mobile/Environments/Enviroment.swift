//
//  Enviroment.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 02/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import SwiftSoup
import UIKit

class Environment {
    static let X5Color = UIColor.rbg(r: 91, g: 149, b: 165)
    
    static let X5URL = "http://x5learn.org/"
    
    static func makeQueryURL (keyWord: String, contentType: String) -> String {
        return "https://platform.x5gon.org/api/v1/recommend/oer_materials?text=\"" + keyWord + "\"&type=" + contentType
    }
    
    static var mainViewController:MainViewController? = nil
    static var homeViewContoller:HomeViewController? = nil
    static var csrfToken = ""
    
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
        queryCSRFToken()
        return self.csrfToken
    }

}

