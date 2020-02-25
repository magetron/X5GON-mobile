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
    var contentLink: URL
    var likes: Int
    var disLikes: Int
    var id: Int
    var description: String
    var suggestedContents = [Content]()
    var wiki = Wiki.init(chunks: [])
            
    //MARK: Inits
    init(title: String, id: Int, channelName: String, description: String, url: URL) {
        self.thumbnail = UIImage.init(named: title) ?? UIImage.init(named: "Video Placeholder")!
        self.title = title
        self.views = Int(arc4random_uniform(1000000))
        self.duration = 0
        self.id = id
        self.likes = 0
        self.disLikes = 0
        self.description = description
        self.channel = Channel.init(name: channelName, image: UIImage.init(named: channelName) ?? UIImage.init(named: "Channel Placeholder")!)
        self.contentLink = url
    }
    
    func fetchContentInfo () {
        fatalError("error: directly calling content generateContentInfo()")
    }
    
    func fetchSuggestedContents () {
        fatalError("error: directly calling content fetchSuggestedContents()")
    }
    
    func fetchWikiChunkEnrichments () {
        self.wiki = API.fetchWikiChunkEnrichments(ids: [id])
        print(wiki)
    }
    
    func like () {
        self.likes += 1;
    }
    
    func dislike () {
        self.disLikes += 1;
    }
    
}
