//
//  SubscriptionsChannelViewCell.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 19/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//
import Foundation
import UIKit

class SubscriptionsCVCell: UICollectionViewCell {
    //MARK: - Property
    /// This is a `UIImageView` which is used to display channel pictures
    @IBOutlet weak var channelPic: UIImageView!
    ///Customise Subscription Cell
    func customisation() {
        self.channelPic.layer.cornerRadius = 25
        self.channelPic.clipsToBounds = true
    }
    //MARK: - View Lifecycle
    /// /// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file. And load `customisation` Method
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
        channelPic.accessibilityIdentifier = "Image--ChannelPic"
    }
}
