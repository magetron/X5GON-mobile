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
    func onLikeTap(completion: @escaping () -> Void)
    ///Function will be called when `dislike` button is tapped
    func onDisLikeTap(completion: @escaping () -> Void)
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
    
    var bookmarkButton: UIButton!
    var content: Content!

    var onLikeTapFunc = { (completion: @escaping () -> Void) -> Void in return}
    var onDisLikeTapFunc = { (completion: @escaping () -> Void) -> Void in return}
    
    func set(content: Content!, onLikeTapFunc: @escaping (@escaping () -> Void) -> Void, onDisLikeTapFunc: @escaping (@escaping () -> Void) -> Void) {
        self.content = content
        
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
        
        if (!(MainController.navViewController?.playerView.contentLiked)!) {
            self.thumbUp.image = UIImage.init(systemName: "hand.thumbsup")
        } else {
            self.thumbUp.image = UIImage.init(systemName: "hand.thumbsup.fill")
        }
        
        if (!(MainController.navViewController?.playerView.contentDisliked)!) {
            self.thumbDown.image = UIImage.init(systemName: "hand.thumbsdown")
        } else {
            self.thumbDown.image = UIImage.init(systemName: "hand.thumbsdown.fill")
        }
        
        self.bookmarkButton = UIButton(frame: CGRect(x:300, y:50, width:100, height:22))
        self.bookmarkButton.setTitleColor(UIColor.systemBlue, for: .normal)
        self.bookmarkButton.setTitle("Bookmark", for: .normal)
        if (MainController.user.bookmarkedContent.contains(self.content)) { self.bookmarkButton.setImage(UIImage.init(systemName: "bookmark.fill"), for: .normal)
        } else {
            self.bookmarkButton.setImage(UIImage.init(systemName: "bookmark"), for: .normal)
        }
        let bookmarkTap = UITapGestureRecognizer(target: self, action: #selector(self.bookmarkCurrentContent))
        self.bookmarkButton.isUserInteractionEnabled = true
        self.bookmarkButton.addGestureRecognizer(bookmarkTap)
        self.addSubview(bookmarkButton)
    }
    
    @objc func onLikeTap () {
        if (!(MainController.navViewController?.playerView.contentLiked)!) {
            onLikeTapFunc {
                self.thumbUp.image = UIImage.init(systemName: "hand.thumbsup.fill")
            }
        } else {
            onLikeTapFunc {
                self.thumbUp.image = UIImage.init(systemName: "hand.thumbsup")
            }
        }
    }
    
    @objc func onDisLikeTap () {
        if (!(MainController.navViewController?.playerView.contentDisliked)!) {
            onDisLikeTapFunc {
                self.thumbDown.image = UIImage.init(systemName: "hand.thumbsdown.fill")
            }
        } else {
            onDisLikeTapFunc {
                self.thumbDown.image = UIImage.init(systemName: "hand.thumbsdown")
            }
        }
    }
    
    @objc func bookmarkCurrentContent() {
        if (MainController.user.bookmarkedContent.contains(self.content)) {
            MainController.user.unbookmark(content: self.content)
            self.bookmarkButton.setImage(UIImage.init(systemName: "bookmark"), for: .normal)
        } else {
            MainController.user.bookmark(content: self.content)
            self.bookmarkButton.setImage(UIImage.init(systemName: "bookmark.fill"), for: .normal)
        }
        MainController.userViewController?.tableView.reloadDataWithAnimation()
        MainController.navViewController?.playerView.tableView.reloadDataWithAnimation()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.bookmarkButton.setImage(UIImage.init(systemName: "bookmark"), for: .normal)
    }
    
}
