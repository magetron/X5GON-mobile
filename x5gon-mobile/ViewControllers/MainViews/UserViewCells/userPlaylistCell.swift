//
//  UserPlaylistCell.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 15/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class userPlaylistCell: UITableViewCell {
    //
    /// UIImageView in storyboard
    @IBOutlet var pic: UIImageView!
    /// UILabel in storyboard
    @IBOutlet var title: UILabel!
    /// UILabel in storybaord
    @IBOutlet var channel: UILabel!

    func customisation() {
        pic.layer.cornerRadius = 5
        pic.clipsToBounds = true
    }

    // MARK: View Lifecycle

    /// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
}
