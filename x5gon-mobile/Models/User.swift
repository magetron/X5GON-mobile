//
//  UserModel.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    //MARK: Properties
    /// This is name Variable
    let name: String
    /// This is a `UIImage` that is used to display profile picture
    let profilePic: UIImage
    ///This is a `UIImage`that is used to disply background Image
    let backgroundImage: UIImage
    /// This is a set of `Content`s that is used to store user's bookmarked `Content`
    var bookmarkedContent = Set<Content>()
    /// This is a list of `Content` that is used to store history `Content`
    var historyContent = [Content]()
    

    /// Initialising user
    init(name: String, profilePic: UIImage, backgroundImage: UIImage) {
        self.profilePic = profilePic
        self.backgroundImage = backgroundImage
        self.name = name
    }
    
    //MARK: Methods
    ///This is used to generateDefaultUser for testing purpose
    static func generateDefaultUser () -> User {
        //Dummy Data
        let user = User.init(name: "Patrick Wu", profilePic: UIImage.init(named: "profilePic")!, backgroundImage: UIImage.init(named: "banner")!)
        return user
    }
    /**
     Bookmark a `Content`
     
     - Parameters:
        - content: self-defined type `Content`
     
     
     ### Usage Example: ###
     ````
      MainController.user.bookmark(content)
     ````
     */
    func bookmark (content: Content) {
        bookmarkedContent.insert(content)
    }
    
    func unbookmark (content: Content) {
        bookmarkedContent.remove(content)
    }
    
}
