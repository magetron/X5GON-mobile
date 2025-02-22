//
//  APIAdapter.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 11/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

/// API Aadpater Protocol, used to define functions to generate different URLs for our App
protocol APIAdapter {
    /// Reuturn rootURL
    static func rootURL() -> String

    /// Return APIVersion in url form
    static func APIVersion() -> String

    /// Generate Content Query using `keywords` and `contentType`
    static func generateContentQueryURL(keyWord: String, contentType: String) -> String

    /// Generate login Query URL
    static func generateLoginQueryURL() -> String

    /// Generate logout Query URL
    static func gererateLogoutQueryURL() -> String

    /// Generate User Seesion Query URL
    static func generateUserSessionQueryURL() -> String

    /// Gnerate Featured `Content` URL
    static func generateFeaturedContentURL() -> String

    /// Gnerate Featured `Note` URL
    static func generateNotesURL() -> String

    /// Gnerate Featured `Note` URL,  with id as parameter
    static func generateNotesURL(id: Int) -> String

    /**
     Generate **Bookmark**  url with `id`

     - Parameters:
     - id: Content id, `Int`
     - bookmark:  `Bool` value if the content is being bookmarked

     - returns:
     bookmark url

     */
    static func TBD_generateBookmarkURL(id: Int, bookmark: Bool) -> String

    /// Generate`Report` content url
    static func TBD_generateReportURL(id: Int) -> String

    static func TBD_generateVoteURL(id: Int) -> String
}
