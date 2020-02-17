//
//  X5LearnAdapter.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 16/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

class X5LearnAPIAdapter : APIAdapter {
    
    static func rootURL () -> String {
        return "http://x5learn.org/"
    }
    
    static func APIVersion() -> String {
        return "api/v1/"
    }
    
    static func generateContentQueryURL(keyWord: String, contentType: String) -> String {
        return rootURL() + APIVersion() + "search/?text=" + keyWord
    }
    
    static func generateLoginQueryURL() -> String {
        return rootURL() + "login"
    }
    
    static func gererateLogoutQueryURL() -> String {
        return rootURL() + "logout"
    }
    
    static func generateUserSessionQueryURL() -> String {
        return rootURL() + APIVersion() + "session"
    }
    
    static func generateFeaturedContentURL() -> String {
        return rootURL() + APIVersion() + "featured"
    }
    
}

