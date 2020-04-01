//
//  userHistoryViewCell.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 28/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class userHistoryViewCell: UITableViewCell {
    // UIImageView in storyboard
    @IBOutlet var videoThumbnail: UIImageView!
    // UILabel in storyboard
    @IBOutlet var videoTitle: UILabel!
    // UILabel in storyboard
    @IBOutlet var videoChannel: UILabel!

    /**
     set History Video Content

     - Parameters:
        - thumbnail: UIImage
        - title: String
        - channel: String

     ### Usage Example: ###
     ````
     set(thumbnail, title, channel)
     ````
     */
    func set(thumbnail: UIImage, title: String, channel: String) {
        videoThumbnail.image = thumbnail
        videoTitle.text = title
        videoChannel.text = channel
    }
}
