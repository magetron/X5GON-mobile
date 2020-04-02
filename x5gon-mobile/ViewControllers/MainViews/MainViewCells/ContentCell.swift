//
//  VideoCell.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 01/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

/// This is a `Contentcell` used to hold the `content`
class ContentCell: UITableViewCell {
    // MARK: - Properties

    /// This is a `UIImageView` which is used to display video Thumbnail.
    @IBOutlet var videoThumbnail: UIImageView!
    /// This is a `UILabel` which is used to display the video duration Time.
    @IBOutlet var durationLabel: UILabel!
    /// This is a `UIImageView` which is used to display channel picture.
    @IBOutlet var channelPic: UIImageView!
    /// This is a `UILabel` which is used to display the video Label.
    @IBOutlet var videoTitle: UILabel!
    /// This is a `UILabel` which is used to display the video description.
    @IBOutlet var videoDescription: UILabel!
    /// Content id ,defined by the backend
    var contentId = 0

    // MARK: - Methods

    /// Customise View
    func customisation() {
        channelPic.layer.cornerRadius = 24
        channelPic.clipsToBounds = true
        durationLabel.layer.borderWidth = 0.5
        durationLabel.layer.borderColor = UIColor.white.cgColor
        durationLabel.sizeToFit()

        isUserInteractionEnabled = true
        let longPressGestureRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(reportContent))
        addGestureRecognizer(longPressGestureRecogniser)
    }

    /// Set each properties of content into corresponding part of cell in UITableView
    func set(content: Content) {
        videoThumbnail.image = content.thumbnail
        durationLabel.text = " \(content.duration.secondsToFormattedString()) "
        durationLabel.layer.borderColor = UIColor.lightGray.cgColor
        durationLabel.layer.borderWidth = 1.0
        channelPic.image = content.channel.image
        videoTitle.text = content.title
        videoDescription.text = "\(content.channel.name)  • \(content.views)"
        contentId = content.id
    }

    /// ReportContent Operataion
    @objc func reportContent() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        let alert = UIAlertController(title: "Do you want to report this content as inappropriate?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in MainController.reportContent(id: self.contentId, reason: "") }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        MainController.homeViewController!.present(alert, animated: true, completion: nil)
    }

    // MARK: - Delegate

    /// Prepares a reusable cell for reuse by the table view's delegate.
    override func prepareForReuse() {
        super.prepareForReuse()
        videoThumbnail.image = UIImage(named: "emptyTumbnail")
        durationLabel.text = nil
        channelPic.image = nil
        videoTitle.text = nil
        videoDescription.text = nil
    }

    /// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file. And load `customisation` Method
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
}
