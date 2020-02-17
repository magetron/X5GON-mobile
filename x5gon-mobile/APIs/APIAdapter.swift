//
//  APIAdapter.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 11/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

protocol APIAdapter {
    static func rootURL () -> String
    static func APIVersion () -> String
    static func generateContentQueryURL (keyWord: String, contentType: String) -> String
    static func generateLoginQueryURL () -> String
    static func gererateLogoutQueryURL () -> String
    static func generateUserSessionQueryURL () -> String
    static func generateFeaturedContentURL () -> String
}
