//
//  Model.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 31/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class Content {
    
    //MARK: Properties
    var thumbnail: UIImage
    let title: String
    let views: Int
    let channel: Channel
    var duration: Int
    var contentLink: URL!
    var likes: Int
    var disLikes: Int
    var suggestedContents = [Content]()
        
    //MARK: Inits
    init(title: String, channelName: String, url: URL) {
        self.thumbnail = UIImage.init(named: title) ?? UIImage.init(named: "Video Placeholder")!
        self.title = title
        self.views = Int(arc4random_uniform(1000000))
        self.duration = Int(arc4random_uniform(400))
        self.likes = Int(arc4random_uniform(1000))
        self.disLikes = Int(arc4random_uniform(1000))
        self.channel = Channel.init(name: channelName, image: UIImage.init(named: channelName) ?? UIImage.init(named: "Channel Placeholder")!)
        self.contentLink = url
    }
    
    func fetchContentInfo () {
        fatalError("error: directly calling content generateContentInfo()")
    }
    
    func fetchSuggestedContents () {
        fatalError("error: directly calling content fetchSuggestedContents()")
    }
    
    static func fetchDefaultContents () -> [Content] {
        fatalError("error: directly calling content fetchDefaultContents()")
    }
    
    func like () {
        self.likes += 1;
    }
    
    func dislike () {
        self.disLikes += 1;
    }
    
}
