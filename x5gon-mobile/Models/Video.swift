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
    
    override init (title: String, channelName: String, url: URL) {
        super.init(title: title, channelName: channelName, url: url)
        self.fetchContentInfo()
    }
    
    override func fetchSuggestedContents (refresher: @escaping () -> Void) {
        DispatchQueue.global().async {
            let videos = API.fetchContents(keyWord: self.title, contentType: "video")
            super.suggestedContents = videos
            OperationQueue.main.addOperation ({
                 refresher()
            })
        }
    }
    
    override func fetchContentInfo() {
        AVAsset(url: contentLink).generateThumbnail { [weak self] (image, duration) in
            DispatchQueue.main.async {
                guard let image = image, let duration = duration else {
                    return
                }
                self?.thumbnail = image
                self?.duration = duration
            }
        }
    }
    
}
