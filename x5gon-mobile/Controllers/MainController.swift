//
//  MainController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 12/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class MainController {
    /// MainViewController
    static var mainViewController:MainViewController?
    /// HomeViewController
    static var homeViewController:HomeViewController?
    /// NavViewController
    static var navViewController:NavViewController?
    /// SearchResultsViewController
    static var searchResultsViewController:SearchResultsViewController?
    ///FeaturedViewController
    static var featuredViewController:FeaturedViewController?
    ///UserViewController
    static var UserViewController:UserViewController?
    /// User Placeholder
    static var user = User.generateDefaultUser()
    /// OperationQueue
    static var queue = OperationQueue()
    
    
    /**
     Set top bar hide status
     
     - Parameters:
       - hide:Type: **Bool**
     
     
     ### Usage Example: ###
     ````
     MainController.setHideTopBar(true)
     ````
     */
    static func setHideTopBar(hide: Bool) {
        if (hide) {
            navViewController?.navigationBar.barTintColor = UIColor.black
            mainViewController?.tabBarView.collectionView.isHidden = true
            mainViewController?.tabBarView.backgroundColor = UIColor.black
        } else {
            navViewController?.navigationBar.barTintColor = Environment.X5Color
            mainViewController?.tabBarView.collectionView.isHidden = false
            mainViewController?.tabBarView.backgroundColor = Environment.X5Color
        }
    }      
    
    static func fetchDefaultContents () -> [Content] {
        let contents = API.fetchContents(keyWord: "science", contentType: "any")
        return contents
    }
    
    static func fetchFeaturedContents () -> [Content] {
        return API.fetchFeaturedContents()
    }
    
    
    /**
     Search on X5GON database for given `Keywords` and `contentType`
     
     - Parameters:
     - keyword: keyword to search
     - contentType:  content Type
     - returns:
     list of Contents
     
     
     ### Usage Example: ###
     ````
     MainController.search("science", "pdf")
     ````
     */
    static func search (keyword: String, contentType: String) -> [Content] {
        return API.fetchContents(keyWord: keyword, contentType: contentType)
    }
    
    /**
     Login using `username` and `passwords`
     
     - Parameters:
       - username: Username  type:`String` read from UITextField
       - password:  Passsword type `String` read from UITextField
     - returns:
     login status in **Bool** type
     
     
     ### Usage Example: ###
     ````
     MainController.login(username,password,csrfToken)
     ````
     */
    static func login (username: String, password: String) -> Bool {
        logout()
        let csrfToken = API.fetchCSRFToken()
        API.authenticationToken = API.fetchLoginTokenWith(username: username, password: password, csrfToken: csrfToken)
        refresher(updateContent: {() -> Void in
            self.user = API.fetchUser()
            MainController.UserViewController?.setUser(user: self.user)
        }, viewReload: {() -> Void in MainController.UserViewController?.tableView.reloadData()
        })
        return API.authenticationToken != ""
    }
    
    /// logout
    static func logout () {
        API.authenticationToken = ""
        API.logout()
        user = User.generateDefaultUser()
    }
    
    static func addHistory (content: Content) {
        MainController.user.historyContent.append(content)
    }
    
    /*
    static func DEPRECATED_fetchDefaultContents() -> [Content] {
        var items = [Content]()
        let pdf = PDF.init(title: "Community Meeting 2016", channelName: "Blender Foundation", url: URL.init(string: "https://download.blender.org/institute/sig2016-2.pdf")!)
        items.append(pdf)
        let video = Video.init(title: "Big Buck Bunny", channelName: "Blender Foundation", url: URL.init(string: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4")!)
        items.append(video)
        items.append(contentsOf: API.DEPRECATED_fetchContents(keyWord: "science"))
        return items
    }*/
    
}
