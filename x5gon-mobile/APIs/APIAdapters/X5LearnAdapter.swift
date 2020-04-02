//
//  X5LearnAdapter.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 16/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

/// `X5LearnAPIAdapter` use to generate url base on root url **http://x5learn.org\/**
class X5LearnAPIAdapter: APIAdapter {
    /// Generate X5Learn Root url **http://x5learn.org\/**
    static func rootURL() -> String {
        return "http://x5learn.org/"
    }

    /// Generate X5Learn APIVersion **api/v1/**
    static func APIVersion() -> String {
        return "api/v1/"
    }

    /**
     Generate X5Learn search url with `keyword`

     - Parameters:
     - keyWord: keywords
     - contentType:  type of Content, currently support `pdf`, `audio`, `video`

     - returns:
     search url

     ### Usage Example: ###
     ````
     X5LearnAPIAdapter.generateContentQueryURL("Science","pdf")
     ````

     */
    static func generateContentQueryURL(keyWord: String, contentType _: String) -> String {
        return rootURL() + APIVersion() + "search/?text=" + keyWord
    }

    /// Generate X5Learn login query URL
    static func generateLoginQueryURL() -> String {
        return rootURL() + "login"
    }

    /// Generate X5Learn logout query URL
    static func gererateLogoutQueryURL() -> String {
        return rootURL() + "logout"
    }

    /// Generate X5Learn User Session Query URL
    static func generateUserSessionQueryURL() -> String {
        return rootURL() + APIVersion() + "session"
    }

    /// Generate X5Learn FeaturedContent URL
    static func generateFeaturedContentURL() -> String {
        return rootURL() + APIVersion() + "featured"
    }

    /// Generate X5Learn Wiki Chunk Enrichments URL
    static func generateWikiChunkEnrichmentsURL() -> String {
        return rootURL() + APIVersion() + "wikichunk_enrichments"
    }

    /// Generate X5Learn Notes URL
    static func generateNotesURL() -> String {
        return rootURL() + APIVersion() + "note"
    }

    /// Generate X5Learn Notes URL with Id as parameter;
    static func generateNotesURL(id: Int) -> String {
        return rootURL() + APIVersion() + "note/\(id)"
    }

    /// Generate`Bookmark` content url
    static func TBD_generateBookmarkURL(id: Int, bookmark _: Bool) -> String {
        return rootURL() + APIVersion() + "bookmark/\(id)"
    }

    /// Generated `Report` content url
    static func TBD_generateReportURL(id: Int) -> String {
        return rootURL() + APIVersion() + "report/\(id)"
    }
}
