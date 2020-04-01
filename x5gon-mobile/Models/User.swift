//
//  UserModel.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject, NSCoding, NSSecureCoding {
    // MARK: Properties

    /// This is name Variable
    let name: String
    /// This is a `UIImage` that is used to display profile picture
    let profilePic: UIImage
    /// This is a `UIImage`that is used to disply background Image
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

    // MARK: Methods

    /// This is used to generateDefaultUser for testing purpose
    static func generateDefaultUser() -> User {
        // Dummy Data
        let user = User(name: "Tmp User #\(Int.random(in: 1 ..< 2000))", profilePic: UIImage(named: "profilePic")!, backgroundImage: UIImage(named: "banner")!)
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
    func bookmark(content: Content) {
        bookmarkedContent.insert(content)
        API.updateBookmark(id: content.id, bookmark: true)
    }

    func unbookmark(content: Content) {
        bookmarkedContent.remove(content)
        API.updateBookmark(id: content.id, bookmark: false)
    }

    // MARK: Persistant Data

    required convenience init(coder decoder: NSCoder) {
        let name = decoder.decodeObject(forKey: "name") as! String
        self.init(name: name, profilePic: UIImage(named: "profilePic")!, backgroundImage: UIImage(named: "banner")!)
    }

    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
    }

    static var supportsSecureCoding: Bool {
        return true
    }
}
