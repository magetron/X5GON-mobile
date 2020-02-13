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
}

class X5GONAPIAdapter : APIAdapter {


    static func rootURL () -> String {
        return "https://platform.x5gon.org/"
    }
    
    static func APIVersion() -> String {
        return "api/v1/"
    }
    
    static func generateContentQueryURL(keyWord: String, contentType: String) -> String {
        return rootURL() + APIVersion() + "recommend/oer_materials?text=" + keyWord + "&type=" + contentType
    }
    
    static func generateLoginQueryURL() -> String {
        fatalError("error: X5GON does not provide a login URL")
    }
    
    static func gererateLogoutQueryURL() -> String {
        fatalError("error: X5GON does not provide a logout URL")
    }
    
}

class X5LearnAPIAdapter : APIAdapter {
    
    static func rootURL () -> String {
        return "http://x5learn.org/"
    }
    
    static func APIVersion() -> String {
        return "api/v1/"
    }
    
    static func generateContentQueryURL(keyWord: String, contentType: String) -> String {
        fatalError("error: X5Learn does not provide a content query URL")
    }
    
    static func generateLoginQueryURL() -> String {
        return rootURL() + "login"
    }
    
    static func gererateLogoutQueryURL() -> String {
        return rootURL() + "logout"
    }
    
    
    
}

