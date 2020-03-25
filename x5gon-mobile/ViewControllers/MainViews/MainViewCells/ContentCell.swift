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
    
    var contentId = 0
    
    
    //MARK: - Methods
    /// Customise View
    func customisation()  {
        self.channelPic.layer.cornerRadius = 24
        self.channelPic.clipsToBounds  = true
        self.durationLabel.layer.borderWidth = 0.5
        self.durationLabel.layer.borderColor = UIColor.white.cgColor
        self.durationLabel.sizeToFit()
        
        self.isUserInteractionEnabled = true
        let longPressGestureRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(self.reportContent))
        self.addGestureRecognizer(longPressGestureRecogniser)
        
    }
    
    /// Set each properties of content into corresponding part of cell in UITableView
    func set(content: Content)  {
        self.videoThumbnail.image = content.thumbnail
        self.durationLabel.text = " \(content.duration.secondsToFormattedString()) "
        self.durationLabel.layer.borderColor = UIColor.lightGray.cgColor
        self.durationLabel.layer.borderWidth = 1.0
        self.channelPic.image = content.channel.image
        self.videoTitle.text = content.title
        self.videoDescription.text = "\(content.channel.name)  • \(content.views)"
        self.contentId = content.id
    }
    
    @objc func reportContent() {
        let alert = UIAlertController(title: "Do you want to report this content as inappropriate?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in MainController.reportContent(id: self.contentId, reason: "")}))
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        MainController.navViewController!.present(alert, animated: true, completion: nil)
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

