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
    ///UIImageView in storyboard
    @IBOutlet weak var pic: UIImageView!
    ///UILabel in storyboard
    @IBOutlet weak var title: UILabel!
    ///UILabel in storybaord
    @IBOutlet weak var numberOfVideos: UILabel!
    
    //MARK: View Lifecycle
    override func awakeFromNib() {
        self.pic.layer.cornerRadius = 5
        self.pic.clipsToBounds = true
    }
}
