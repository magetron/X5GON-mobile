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
    static var subscriptionViewController:SubscriptionsViewController?
    static var trendingViewController:TrendingViewController?
    static var accountViewController:AccountViewController?
 
    static var user = User.generateDefaultUser()
    static var authenticationToken = ""
    
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
    
    
    static func fetchDefaultContents() -> [Content] {
        var items = [Content]()
        let pdf = PDF.init(title: "Community Meeting 2016", channelName: "Blender Foundation", url: URL.init(string: "https://download.blender.org/institute/sig2016-2.pdf")!)
        items.append(pdf)
        let defaultKeyWord = "science"
        let defaultPDFs = API.fetchContents(keyWord: defaultKeyWord, contentType: "text") as! [PDF]
        items.append(contentsOf: defaultPDFs)
        let playableVideo = Video.init(title: "Big Buck Bunny", channelName: "Blender Foundation", url: URL.init(string: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4")!)
        items.append(playableVideo)
        let defaultVideos = API.fetchContents(keyWord: defaultKeyWord, contentType: "video") as! [Video]
        items.append(contentsOf: defaultVideos)
        return items
    }
    
    
    static func search (keyword: String, contentType: String) {
        homeViewController?.contents = API.fetchContents(keyWord: keyword, contentType: contentType)
        homeViewController?.tableView.reloadData()
    }
    
    static func login (username: String, password: String) {
        let csrfToken = API.fetchCSRFToken()
        authenticationToken = API.fetchLoginTokenWith(username: username, password: password, csrfToken: csrfToken)
    }
    
    static func logout () {
        authenticationToken = ""
        API.logout()
    }
    
}
