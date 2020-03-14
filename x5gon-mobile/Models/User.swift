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
    let name: String
    let profilePic: UIImage
    let backgroundImage: UIImage
    var playlists = [Playlist]()
    var bookmarkedContent = Set<Content>()
    var historyContent = [Content]()

    init(name: String, profilePic: UIImage, backgroundImage: UIImage, playlists: [Playlist]) {
        self.profilePic = profilePic
        self.backgroundImage = backgroundImage
        self.playlists = playlists
        self.name = name
    }
    
    //MARK: Methods
    ///This is used to generateDefaultUser for testing purpose
    static func generateDefaultUser () -> User {
        //Dummy Data
        let data = ["pl-swift": "Swift Tutorials", "pl-node": "NodeJS Tutorials", "pl-javascript": "JavaScript ES6 / ES2015 Tutorials", "pl-angular": "Angular 2 Tutorials", "pl-rest": "REST API Tutorials (Node, Express & Mongo)", "pl-react": "React development", "pl-mongo": "Mongo db"]
        let user = User.init(name: "Patrick Wu", profilePic: UIImage.init(named: "profilePic")!, backgroundImage: UIImage.init(named: "banner")!, playlists: [Playlist]())
        for (key, value) in data {
            let image = UIImage.init(named: key)
            let name = value
            let playlist = Playlist.init(pic: image!, title: name, numberOfVideos: Int(arc4random_uniform(50)))
            user.playlists.append(playlist)
        }
        return user
    }
    
    func bookmark (content: Content) {
        bookmarkedContent.insert(content)
    }
    
}
