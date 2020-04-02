//
//  ChannelModel.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 01/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

/// Used for subsciprition
class Channel {
    /// This is a String which is used to store the name of `Channel`
    let name: String
    /// This is a `UIImage` which is used to display the image of `Channel`
    let image: UIImage
    /// Number of subscribers
    var subscribers = 0

    /// Generate place holder channels, for displaying purpose
    static func generateDefaultChannels() -> [Channel] {
        var channels = [Channel]()
        for _ in 0 ... 18 {
            let name = ""
            let image = UIImage(named: "logo")
            let channel = Channel(name: name, image: image!)
            channels.append(channel)
        }
        channels.myShuffle()
        return channels
    }

    /// Performe `Channel` initialization
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}
