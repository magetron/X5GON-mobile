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
    static var mainViewController:MainViewController?
    static var homeViewController:HomeViewController?
    static var navViewController:NavViewController?
    static var searchResultsViewController:SearchResultsViewController?
    static var featuredViewController:FeaturedViewController?
    static var accountViewController:AccountViewController?
 
    static var user = User.generateDefaultUser()
    
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
        return API.fetchContents(keyWord: "science", contentType: "any")
    }
    
    static func fetchFeaturedContents () -> [Content] {
        return API.fetchFeaturedContents()
    }
    
    static func search (keyword: String, contentType: String) -> [Content] {
        return API.fetchContents(keyWord: keyword, contentType: contentType)
    }
    
    static func login (username: String, password: String) -> Bool {
        logout()
        let csrfToken = API.fetchCSRFToken()
        API.authenticationToken = API.fetchLoginTokenWith(username: username, password: password, csrfToken: csrfToken)
        refresher(updateContent: {() -> Void in MainController.accountViewController?.setUser(user: API.fetchUser())}, viewReload: {() -> Void in MainController.accountViewController?.tableView.reloadData()
        })
        return API.authenticationToken != ""
    }
    
    static func logout () {
        API.authenticationToken = ""
        API.logout()
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
