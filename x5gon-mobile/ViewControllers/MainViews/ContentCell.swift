//
//  VideoCell.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 01/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class ContentCell: UITableViewCell {
    //MARK: - Properties
    ///This is a `UIImageView` which is used to display video Thumbnail.
    @IBOutlet weak var videoThumbnail: UIImageView!
    ///This is a `UILabel` which is used to display the video duration Time.
    @IBOutlet weak var durationLabel: UILabel!
    /// This is a `UIImageView` which is used to display channel picture.
    @IBOutlet weak var channelPic: UIImageView!
    ///This is a `UILabel` which is used to display the video Label.
    @IBOutlet weak var videoTitle: UILabel!
    /// This is a `UILabel` which is used to display the video description.
    @IBOutlet weak var videoDescription: UILabel!
    
    
    //MARK: - Methods
    /// Customise View
    func customisation()  {
        self.channelPic.layer.cornerRadius = 24
        self.channelPic.clipsToBounds  = true
        self.durationLabel.layer.borderWidth = 0.5
        self.durationLabel.layer.borderColor = UIColor.white.cgColor
        self.durationLabel.sizeToFit()
    }
    
    /// Set each properties of content into corresponding part of cell in UITableView
    func set(video: Content)  {
        self.videoThumbnail.image = video.thumbnail
        self.durationLabel.text = " \(video.duration.secondsToFormattedString()) "
        self.durationLabel.layer.borderColor = UIColor.lightGray.cgColor
        self.durationLabel.layer.borderWidth = 1.0
        self.channelPic.image = video.channel.image
        self.videoTitle.text = video.title
        self.videoDescription.text = "\(video.channel.name)  • \(video.views)"
    }
    //MARK: - Delegate
    /// Prepares a reusable cell for reuse by the table view's delegate.
    override func prepareForReuse() {
        super.prepareForReuse()
        self.videoThumbnail.image = UIImage.init(named: "emptyTumbnail")
        self.durationLabel.text = nil
        self.channelPic.image = nil
        self.videoTitle.text = nil
        self.videoDescription.text = nil
    }
    
    /// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file. And load `customisation` Method
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customisation()
    }
}

