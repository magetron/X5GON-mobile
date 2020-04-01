//
//  headerCell.swift
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
    /// Function will be called when `dislike` button is tapped
    func onDisLikeTap(completion: @escaping () -> Void)
}

class headerCell: UITableViewCell {
    /// This is a `UILabel` used to display title.
    @IBOutlet var title: UILabel!
    /// This is a `UILabel` used to display number of times this content being viewed.
    @IBOutlet var viewCount: UILabel!
    /// This is a `UILabel` used to display number of time this content being liked.
    @IBOutlet var likes: UILabel!
    /// This is a `UITextView`used to display the descrption of the content.
    @IBOutlet var descriptionTextView: UITextView!
    /// This is a `UILabel` used to display number of times this content being disliked.
    @IBOutlet var disLikes: UILabel!
    /// This is a `UILabel`used to display the channel title
    @IBOutlet var channelTitle: UILabel!
    /// This is a `UIImageView` used to display the channel picture
    @IBOutlet var channelPic: UIImageView!
    /// This is a `UILabel` used to display the channelSubsvriber's name.
    @IBOutlet var channelSubscribers: UILabel!
    /// This is a `UIImageView` used to display the thumbUp Icon.
    @IBOutlet var thumbUp: UIImageView!
    /// This is a `UIImageView` used to display the thumbDown Icon.
    @IBOutlet var thumbDown: UIImageView!

    var bookmarkButton: UIButton!
    var content: Content!

    var onLikeTapFunc = { (_: @escaping () -> Void) -> Void in }
    var onDisLikeTapFunc = { (_: @escaping () -> Void) -> Void in }

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
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(onLikeTap))
        let disLikeTap = UITapGestureRecognizer(target: self, action: #selector(onDisLikeTap))
        thumbUp.isUserInteractionEnabled = true; thumbDown.isUserInteractionEnabled = true
        thumbUp.addGestureRecognizer(likeTap); thumbDown.addGestureRecognizer(disLikeTap)

        if !(MainController.navViewController?.playerView.contentLiked)! {
            thumbUp.image = UIImage(systemName: "hand.thumbsup")
        } else {
            thumbUp.image = UIImage(systemName: "hand.thumbsup.fill")
        }

        if !(MainController.navViewController?.playerView.contentDisliked)! {
            thumbDown.image = UIImage(systemName: "hand.thumbsdown")
        } else {
            thumbDown.image = UIImage(systemName: "hand.thumbsdown.fill")
        }

        bookmarkButton = UIButton(frame: CGRect(x: 300, y: 50, width: 100, height: 22))
        bookmarkButton.setTitleColor(UIColor.systemBlue, for: .normal)
        bookmarkButton.setTitle("Bookmark", for: .normal)
        if MainController.user.bookmarkedContent.contains(self.content) { bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        let bookmarkTap = UITapGestureRecognizer(target: self, action: #selector(bookmarkCurrentContent))
        bookmarkButton.isUserInteractionEnabled = true
        bookmarkButton.addGestureRecognizer(bookmarkTap)
        addSubview(bookmarkButton)
    }

    @objc func onLikeTap() {
        if !(MainController.navViewController?.playerView.contentLiked)! {
            onLikeTapFunc {
                self.thumbUp.image = UIImage(systemName: "hand.thumbsup.fill")
            }
        } else {
            onLikeTapFunc {
                self.thumbUp.image = UIImage(systemName: "hand.thumbsup")
            }
        }
    }

    @objc func onDisLikeTap() {
        if !(MainController.navViewController?.playerView.contentDisliked)! {
            onDisLikeTapFunc {
                self.thumbDown.image = UIImage(systemName: "hand.thumbsdown.fill")
            }
        } else {
            onDisLikeTapFunc {
                self.thumbDown.image = UIImage(systemName: "hand.thumbsdown")
            }
        }
    }

    @objc func bookmarkCurrentContent() {
        if MainController.user.bookmarkedContent.contains(content) {
            MainController.user.unbookmark(content: content)
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        } else {
            MainController.user.bookmark(content: content)
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
        MainController.userViewController?.tableView.reloadDataWithAnimation()
        MainController.navViewController?.playerView.tableView.reloadDataWithAnimation()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
    }
}
