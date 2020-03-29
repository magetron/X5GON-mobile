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
    
    var avPlayerItem : AVPlayerItem?
    
    /// Performe `Video` initialization
    override init (title: String, id: Int, channelName: String, description: String, url: URL) {
        super.init(title: title, id: id, channelName: channelName, description: description, url: url)
        self.fetchContentInfo()
    }
    /// Fetching content using **video** as contentType
    override func fetchSuggestedContents () {
        let videos = MainController.fetchContents(keyWord: self.title, contentType: "video", cancellable: true)
        super.suggestedContents = videos
    }
    
    /**
     Fetching `Content` information
     
     ### Usage Example: ###
     ````
      self.fetchContentInfo()
     ````
     */
    override func fetchContentInfo() {
        AVAsset(url: contentLink).generateInformation { [weak self] (image, duration, playerItem) in
            guard let image = image, let duration = duration, let playerItem = playerItem else {
                return
            }
            self?.thumbnail = image
            self?.duration = duration
            self?.avPlayerItem = playerItem
        }
    }
    
}
