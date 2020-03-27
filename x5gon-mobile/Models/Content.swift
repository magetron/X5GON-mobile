//
//  Model.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 31/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class Content: Hashable {
    /// Self defined operator ==, return `true` if both equals, else return `false`
    static func == (lhs: Content, rhs: Content) -> Bool {
        return lhs.id == rhs.id
    }
    /// Perform hash
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    //MARK: Properties
    /// This is a `UIImage` which is used to display thumbnail of `Content`
    var thumbnail: UIImage
    /// This is the title of `Content`
    let title: String
    /// Number of views of `Content`
    let views: Int
    /// The related`Channel` of `Content`
    let channel: Channel
    /// Duration of `Content`
    var duration: Int
    /// Content Link, used to fetch content from this given link
    var contentLink: URL
    ///Number of likes for the `Content`
    var likes: Int
    ///Number of dislikes for the `Content`
    var disLikes: Int
    /// ID for the content
    var id: Int
    /// This is the description of the `Content`
    var description: String
    /// This is a list of `Content`s which is used to store suggested Contents, the suggested Content will base on the current `Content`'s name
    var suggestedContents = [Content]()
    /// Initialization of wiki
    var wiki = Wiki.init(chunks: [])
            
    //MARK: Inits
    /// Performe `Content` initialization
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
    /// Aviode directly calling `generateContentInfo`
    func fetchContentInfo () {
        fatalError("error: directly calling content generateContentInfo()")
    }
    /// Aviode directly calling `fetchSuggestedContents`
    func fetchSuggestedContents () {
        fatalError("error: directly calling content fetchSuggestedContents()")
    }
    
    /**
     Fetch `Content`'s `WikiChunk`
     
     ### Usage Example: ###
     ````
      content.fetchWikiChunkEnrichments()
     ````
     */
    func fetchWikiChunkEnrichments () {
        self.wiki = API.fetchWikiChunkEnrichments(ids: [id])
    }
    /// Increase number of likes
    func like () {
        self.likes += 1;
    }
    /// Increase number of dislikes
    func dislike () {
        self.disLikes += 1;
    }
    
}
