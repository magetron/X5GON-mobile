//
//  Playlist.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 11/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

struct Playlist {
    /// This is a `UIImage` which is used to display picture of `Playlist`
    let pic: UIImage
    /// Used to display `Playlist` title
    let title: String
    /// Used to display number of videos in `Playlist`
    let numberOfVideos: Int
    
    /// Performe `Playlist` initialization
    init(pic: UIImage, title: String, numberOfVideos: Int) {
        self.pic = pic
        self.title = title
        self.numberOfVideos = numberOfVideos
    }
}
