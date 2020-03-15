//
//  File.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 01/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

@objc protocol PlayerViewHeaderCellDelegate {
    /// Function will be called when `like` button is tapped
    func onLikeTap()
    ///Function will be called when `dislike` button is tapped
    func onDisLikeTap()
}

class headerCell: UITableViewCell {
    ///This is a `UILabel` used to display title.
    @IBOutlet weak var title: UILabel!
    ///This is a `UILabel` used to display number of times this content being viewed.
    @IBOutlet weak var viewCount: UILabel!
    ///This is a `UILabel` used to display number of time this content being liked.
    @IBOutlet weak var likes: UILabel!
    ///This is a `UITextView`used to display the descrption of the content.
    @IBOutlet weak var descriptionTextView: UITextView!
    ///This is a `UILabel` used to display number of times this content being disliked.
    @IBOutlet weak var disLikes: UILabel!
    ///This is a `UILabel`used to display the channel title
    @IBOutlet weak var channelTitle: UILabel!
    ///This is a `UIImageView` used to display the channel picture
    @IBOutlet weak var channelPic: UIImageView!
    ///This is a `UILabel` used to display the channelSubsvriber's name.
    @IBOutlet weak var channelSubscribers: UILabel!
    ///This is a `UIImageView` used to display the thumbUp Icon.
    @IBOutlet weak var thumbUp: UIImageView!
    ///This is a `UIImageView` used to display the thumbDown Icon.
    @IBOutlet weak var thumbDown: UIImageView!
    var onLikeTapFunc = { () -> Void in return}
    var onDisLikeTapFunc = { () -> Void in return}
    
    func set(content: Content!, onLikeTapFunc: @escaping () -> Void, onDisLikeTapFunc: @escaping () -> Void) {
        title.text = content!.title
        viewCount.text = "\(content!.views) views"
        descriptionTextView.text = (content.description == "") ? "No description available" : content.description
        descriptionTextView.sizeToFit()
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isEditable = false
        likes.text = String(content!.likes)
        disLikes.text = String(content!.disLikes)
        channelTitle.text = content!.channel.name
        channelPic.image = content!.channel.image
        channelPic.layer.cornerRadius = 25
        channelPic.clipsToBounds = true
        channelSubscribers.text = "\(content!.channel.subscribers) subscribers"
        selectionStyle = .none
        self.onLikeTapFunc = onLikeTapFunc
        self.onDisLikeTapFunc = onDisLikeTapFunc
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(self.onLikeTap))
        let disLikeTap = UITapGestureRecognizer(target: self, action: #selector(self.onDisLikeTap))
        thumbUp.isUserInteractionEnabled = true; thumbDown.isUserInteractionEnabled = true
        thumbUp.addGestureRecognizer(likeTap); thumbDown.addGestureRecognizer(disLikeTap)
    }
    
    @objc func onLikeTap () {
        onLikeTapFunc()
    }
    
    @objc func onDisLikeTap () {
        onDisLikeTapFunc()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
