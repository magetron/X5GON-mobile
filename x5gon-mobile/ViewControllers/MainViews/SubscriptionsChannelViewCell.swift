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
    @IBOutlet weak var channelPic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.channelPic.layer.cornerRadius = 25
        self.channelPic.clipsToBounds = true
    }
}
