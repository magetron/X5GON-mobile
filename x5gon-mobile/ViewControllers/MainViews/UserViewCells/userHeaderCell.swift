//
//  UserHeaderCell.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 15/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class userHeaderCell: UITableViewCell {
    // MARK: -  Properties

    /// UILabel in storyboard
    @IBOutlet var name: UILabel!
    /// UIImageView in storyboard
    @IBOutlet var profilePic: UIImageView!
    /// UIImageView in storyboard
    @IBOutlet var backgroundImage: UIImageView!

    // MARK: - View LifeCycle

    /// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePic.layer.cornerRadius = 25
        profilePic.clipsToBounds = true
    }
}
