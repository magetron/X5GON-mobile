//
//  Enviroment.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 02/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class Environment {
    static let X5Color = UIColor.rbg(r: 91, g: 149, b: 165)
    
    static func makeQueryURL (keyWord: String, contentType: String) -> String {
        return "https://platform.x5gon.org/api/v1/recommend/oer_materials?text=\"" + keyWord + "\"&type=" + contentType
    }
    static var mainViewController:MainViewController? = nil
    static var homeViewContoller:HomeViewController? = nil

}

