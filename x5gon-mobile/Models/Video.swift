//
//  VideoModel.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class Video : Content {
    /// Performe `Video` initialization
    override init (title: String, id: Int, channelName: String, description: String, url: URL) {
        super.init(title: title, id: id, channelName: channelName, description: description, url: url)
        self.fetchContentInfo()
    }
    /// Fetching content using **video** as contentType
    override func fetchSuggestedContents () {
        if (!enriching) {
            super.enriching = true
            let videos = API.fetchContents(keyWord: self.title, contentType: "video")
            super.suggestedContents = videos
            super.enriching = false
        }
    }
    
    /**
     Fetching `Content` information
     
     ### Usage Example: ###
     ````
      self.fetchContentInfo()
     ````
     */
    override func fetchContentInfo() {
        AVAsset(url: contentLink).generateThumbnail { [weak self] (image, duration) in
            guard let image = image, let duration = duration else {
                return
            }
            self?.thumbnail = image
            self?.duration = duration
        }
    }
    
}
