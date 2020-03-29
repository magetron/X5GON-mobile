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
    static var userViewController:UserViewController?
    /// User Placeholder
    static var user = User.generateDefaultUser()
    
    static var DEBUG = true
    
    
    class Queue {
        private static var queue = OperationQueue()
        private static var cancellableTasks = [(URLSessionDataTask, DispatchSemaphore)]()
        
        static let cancellableFetchSwitch = { (dataTask: URLSessionDataTask, sempahore: DispatchSemaphore) -> Void in
            Queue.cancellableTasks.append((dataTask, sempahore))
            return
        }
        static let uncancellableFetchSwitch = { (dataTask: URLSessionDataTask, sempahore: DispatchSemaphore) -> Void in return }
        
        static func addOperation (completion: @escaping () -> Void) {
            queue.addOperation(completion)
        }
        
        static func cancelOperations () {
            for (dataTask, semaphore) in cancellableTasks {
                dataTask.cancel()
                semaphore.signal()
            }
            cancellableTasks.removeAll()
            queue.cancelAllOperations()
        }
        
    }
    
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
    
    static func fetchDefaultContents (cancellable: Bool) -> [Content] {
        return MainController.fetchContents(keyWord: "science", contentType: "any", cancellable: cancellable)
    }
    
    static func fetchFeaturedContents (cancellable: Bool) -> [Content] {
        return cancellable ? API.fetchFeaturedContents(fetchSwitch: Queue.cancellableFetchSwitch) : API.fetchFeaturedContents(fetchSwitch: Queue.uncancellableFetchSwitch)
    }
    
    static func fetchContents (keyWord : String, contentType : String, cancellable: Bool) -> [Content] {
        if cancellable {
            return API.fetchContents(keyWord: keyWord, contentType: contentType, fetchSwitch: Queue.cancellableFetchSwitch)
        } else {
            return API.fetchContents(keyWord: keyWord, contentType: contentType, fetchSwitch: Queue.uncancellableFetchSwitch)
        }
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
    
    static func search (keyword: String, contentType: String, cancellable: Bool) -> [Content] {
        return MainController.fetchContents(keyWord: keyword, contentType: contentType, cancellable: cancellable)
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
        refresherWithLoadingHUD(updateContent: {() -> Void in
            self.user = API.fetchUser()
            MainController.userViewController?.setUser(user: self.user)
        }, viewReload: {() -> Void in MainController.userViewController?.tableView.reloadDataWithAnimation()
        }, view: (MainController.mainViewController?.view)!, cancellable: false)
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
    
    static func getNotes (id: Int) -> String {
        return API.getNotes(id: id)
    }
    
    static func createNotes (id: Int, text: String) {
        return API.createNotes(id: id, text: text)
    }
    
    static func reportContent (id: Int, reason: String) {
        return API.TBD_report(id: id, reason: reason)
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
    
    deinit {
        MainController.Queue.cancelOperations()
    }
    
}
