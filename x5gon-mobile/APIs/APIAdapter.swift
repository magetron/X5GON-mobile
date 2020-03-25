//
//  APIAdapter.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 11/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

protocol APIAdapter {
    
    /// Reuturn rootURL
    static func rootURL () -> String
    
    /// Return APIVersion in url form
    static func APIVersion () -> String
    
    /// Generate Content Query using `keywords` and `contentType`
    static func generateContentQueryURL (keyWord: String, contentType: String) -> String
    
    /// Generate login Query URL
    static func generateLoginQueryURL () -> String
    
    /// Generate logout Query URL
    static func gererateLogoutQueryURL () -> String
    
    /// Generate User Seesion Query URL
    static func generateUserSessionQueryURL () -> String
    
    /// Gnerate Featured `Content` URL
    static func generateFeaturedContentURL () -> String
    
    static func generateNotesURL() -> String
    
    static func generateNotesURL(id: Int) -> String
    
    static func generateReportURL(id: Int) -> String
    
}
