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
    // MARK: - Properties

    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var name: UILabel!

    // MARK: - Method

    func set(content: Content) {
        thumbnail.image = content.thumbnail
        title.text = content.title
        name.text = content.channel.name
    }

    // MARK: - View Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = UIImage(named: "Video Placeholder")
        title.text = nil
        name.text = nil
    }
}
