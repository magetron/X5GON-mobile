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
    @IBOutlet weak var disLikes: UILabel!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var channelPic: UIImageView!
    @IBOutlet weak var channelSubscribers: UILabel!
    var delegate: PlayerViewHeaderCellDelegate?
    
    func set(content: Content!) {
        title.text = content!.title
        viewCount.text = "\(content!.views) views"
        likes.text = String(content!.likes)
        disLikes.text = String(content!.disLikes)
        channelTitle.text = content!.channel.name
        channelPic.image = content!.channel.image
        channelPic.layer.cornerRadius = 25
        channelPic.clipsToBounds = true
        channelSubscribers.text = "\(content!.channel.subscribers) subscribers"
        selectionStyle = .none
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(self.delegate?.onLikeTap))
        let disLikeTap = UITapGestureRecognizer(target: self, action: #selector(self.delegate?.onDisLikeTap))
        likes.isUserInteractionEnabled = true
        disLikes.isUserInteractionEnabled = true
        likes.addGestureRecognizer(likeTap)
        disLikes.addGestureRecognizer(disLikeTap)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
