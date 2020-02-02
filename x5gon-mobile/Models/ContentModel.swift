//
//  Model.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 31/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class ContentModel {
    
    //MARK: Properties
    var thumbnail: UIImage
    let title: String
    let views: Int
    let channel: ChannelModel
    var duration: Int
    var contentLink: URL!
    var likes: Int
    var disLikes: Int
    var suggestedContents = [ContentModel]()
        
    //MARK: Inits
    init(title: String, channelName: String) {
        self.thumbnail = UIImage.init(named: title) ?? UIImage.init(named: "Video Placeholder")!
        self.title = title
        self.views = Int(arc4random_uniform(1000000))
        self.duration = Int(arc4random_uniform(400))
        self.likes = Int(arc4random_uniform(1000))
        self.disLikes = Int(arc4random_uniform(1000))
        self.channel = ChannelModel.init(name: channelName, image: UIImage.init(named: channelName) ?? UIImage.init(named: "Channel Placeholder")!)
    }
    
    func initURL (url : URL, regenerateInfo : Bool) {
        self.contentLink = url
        if (regenerateInfo) {
            generateInfo()
        }
    }
    
    func generateInfo () { }
    
    func fetchSuggestedContents (async : Bool, refresher: @escaping () -> Void) { }
    
}
