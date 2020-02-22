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
    func onLikeTap()
    func onDisLikeTap()
}

class headerCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var disLikes: UILabel!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var channelPic: UIImageView!
    @IBOutlet weak var channelSubscribers: UILabel!
    @IBOutlet weak var thumbUp: UIImageView!
    @IBOutlet weak var thumbDown: UIImageView!
    var onLikeTapFunc = { () -> Void in return}
    var onDisLikeTapFunc = { () -> Void in return}
    
    func set(content: Content!, onLikeTapFunc: @escaping () -> Void, onDisLikeTapFunc: @escaping () -> Void) {
        title.text = content!.title
        viewCount.text = "\(content!.views) views"
        descriptionTextView.text = (content.description == "") ? "No description available" : content.description
        descriptionTextView.sizeToFit()
        descriptionTextView.isScrollEnabled = false
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @objc func onLikeTap () {
        onLikeTapFunc()
    }
    
    @objc func onDisLikeTap () {
        onDisLikeTapFunc()
    }
    
    
}
