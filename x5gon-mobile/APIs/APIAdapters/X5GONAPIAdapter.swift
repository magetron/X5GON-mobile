//
//  X5GONAPIAdapter.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 16/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

class X5GONAPIAdapter : APIAdapter {

    ///Generate X5GON rootURL
    static func rootURL () -> String {
        return "https://platform.x5gon.org/"
    }
    
    /// Add X5GON API version into URL
    static func APIVersion() -> String {
        return "api/v1/"
    }
    
    /**
     Generate X5GON search url with `keyword`
     
     - Parameters:
     - keyWord: keywords
     - contentType:  type of Content, currently support `pdf`, `audio`, `video`
     
     - returns:
     X5GON Search url
     
     
     ### Usage Example: ###
     ````
     X5GONAPIAdapter.generateContentQueryURL("Science","pdf")
     ````

     */
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
    
    static func generateNotesURL() -> String {
        fatalError("error: X5GON does not provide notes URL")
    }
    
    static func generateNotesURL(id: Int) -> String {
        fatalError("error: X5GON does not provide notes URL")
    }
    
    static func TBD_generateReportURL(id: Int) -> String {
        fatalError("error: X5GON does not provide content report URL")
    }
    
    
}

