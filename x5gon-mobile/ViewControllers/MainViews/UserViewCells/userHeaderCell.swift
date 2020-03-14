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
    // UILabel in storyboard
    @IBOutlet weak var name: UILabel!
    //UIImageView in storyboard
    @IBOutlet weak var profilePic: UIImageView!
    //UIImageView in storyboard
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //MARK: LifeCycle
    
    ///Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profilePic.layer.cornerRadius = 25
        self.profilePic.clipsToBounds = true
    }
}


