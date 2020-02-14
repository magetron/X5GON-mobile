//
//  File.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 01/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class headerCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var disLikes: UILabel!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var channelPic: UIImageView!
    @IBOutlet weak var channelSubscribers: UILabel!
    var onLikeTapFunc: (() -> Void) = { () in return }
    var onDisLikeTapFunc: (() -> Void) = { () in return }
    
    
    func set(content: Content!, onLikeTapFunc: @escaping () -> Void, onDisLikeTapFunc: @escaping () -> Void) {
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
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(onLikeTap))
        let disLikeTap = UITapGestureRecognizer(target: self, action: #selector(onDisLikeTap))
        likes.isUserInteractionEnabled = true
        disLikes.isUserInteractionEnabled = true
        likes.addGestureRecognizer(likeTap)
        disLikes.addGestureRecognizer(disLikeTap)
        self.onLikeTapFunc = onLikeTapFunc
        self.onDisLikeTapFunc = onDisLikeTapFunc
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @objc func onLikeTap(sender: UITapGestureRecognizer) {
        onLikeTapFunc()
    }
    
    @objc func onDisLikeTap(sender: UITapGestureRecognizer) {
        onDisLikeTapFunc()
    }
    
}
