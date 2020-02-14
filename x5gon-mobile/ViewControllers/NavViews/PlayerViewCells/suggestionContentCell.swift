//
//  suggestedVideoCell.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 01/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class suggestionContentCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var name: UILabel!
    
    func set(content: Content)  {
        self.thumbnail.image = content.thumbnail
        self.title.text = content.title
        self.name.text = content.channel.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnail.image = UIImage.init(named: "Video Placeholder")
        self.title.text = nil
        self.name.text = nil
    }
    
}
