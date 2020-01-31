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
        AVAsset(url: videoLink).generateThumbnail { [weak self] (image, duration) in
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

