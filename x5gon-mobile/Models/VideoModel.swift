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

class VideoModel : ContentModel {
    
    override func fetchSuggestedContents (async : Bool, refresher: @escaping () -> Void) {
        if (async) {
            DispatchQueue.global().async {
                let videos = VideoController.fetchItems(keyWord: self.title, contentType: "video")
                super.suggestedContents = videos
                OperationQueue.main.addOperation ({
                     refresher()
                })
            }
        } else {
            let videos = VideoController.fetchItems(keyWord: self.title, contentType: "video")
            self.suggestedContents = videos
        }
    }
    
    override func generateInfo() {
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
