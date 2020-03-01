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
    
    @IBOutlet weak var videoThumbnail: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoChannel: UILabel!

    func set(thumbnail: UIImage, title: String, channel: String) {
        videoThumbnail.image = thumbnail
        videoTitle.text = title
        videoChannel.text = channel
    }
}
