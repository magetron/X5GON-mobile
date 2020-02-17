//
//  X5GONAPIAdapter.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 16/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

class X5GONAPIAdapter : APIAdapter {

    static func rootURL () -> String {
        return "https://platform.x5gon.org/"
    }
    
    static func APIVersion() -> String {
        return "api/v1/"
    }
    
    static func generateContentQueryURL(keyWord: String, contentType: String) -> String {
        return rootURL() + APIVersion() + "recommend/oer_materials?text=" + keyWord + "&types=" + contentType
    }
    
    static func generateLoginQueryURL() -> String {
        fatalError("error: X5GON does not provide a login URL")
    }
    
    static func gererateLogoutQueryURL() -> String {
        fatalError("error: X5GON does not provide a logout URL")
    }
    
    static func generateUserSessionQueryURL() -> String {
        fatalError("error: X5GON does not provide a user-session URL")
    }
    
    static func generateFeaturedContentURL() -> String {
        fatalError("error: X5GON does not provide featured contents URL")
    }

    
}

