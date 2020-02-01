//
//  ChannelModel.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 01/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class ChannelModel {
    
    let name: String
    let image: UIImage
    var subscribers = 0
    
    class func fetchData(completion: @escaping (([ChannelModel]) -> Void)) {
        var items = [ChannelModel]()
        for i in 0...18 {
            let name = ""
            let image = UIImage.init(named: "channel\(i)")
            let channel = ChannelModel.init(name: name, image: image!)
            items.append(channel)
        }
        items.myShuffle()
        completion(items)
    }

    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}
