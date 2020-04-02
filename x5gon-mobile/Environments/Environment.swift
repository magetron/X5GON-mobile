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
    /// **x5gon color**
    static let X5Color = UIColor.rbg(r: 91, g: 149, b: 165)

    static func loadLICENSE() -> String {
        if let filepath = Bundle.main.path(forResource: "LICENSE", ofType: "") {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch {
                return "contents could not be loaded"
            }
        } else {
            return "LICENSE not found!"
        }
    }
}
