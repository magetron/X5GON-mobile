//
//  AVAssetExtensions.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 30/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension AVAsset {
    /**
    Generate Thumbnail for `Content`
    
    ### Usage Example: ###
    ````
     AVAsset(url: contentLink).generateThumbnail { [weak self] (image, duration) in
         guard let image = image, let duration = duration else {
             return
         }
         self?.thumbnail = image
         self?.duration = duration
     }
    
    ````
    */
    func generateInformation(completion: @escaping (UIImage?, Int?, AVPlayerItem?) -> Void) {
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let playerItem = AVPlayerItem(asset: self)
            let time = CMTime(seconds: 60.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            let duration = Int(self.duration.seconds)
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image), duration, playerItem)
                } else {
                    completion(nil, nil, nil)
                }
            })
        }
    }
}
