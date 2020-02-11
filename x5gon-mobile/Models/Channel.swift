//
//  ChannelModel.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 01/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class Channel {
    
    let name: String
    let image: UIImage
    var subscribers = 0
    
    static func generateDefaultChannels () -> [Channel] {
        var channels = [Channel]()
        for i in 0...18 {
            let name = ""
            let image = UIImage.init(named: "channel\(i)")
            let channel = Channel.init(name: name, image: image!)
            channels.append(channel)
        }
        channels.myShuffle()
        return channels
    }
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}
