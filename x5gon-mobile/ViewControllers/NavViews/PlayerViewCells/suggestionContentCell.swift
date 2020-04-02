//
//  suggestedVideoCell.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 01/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

/// This is a cell for suggetion `Content`s
class suggestionContentCell: UITableViewCell {
    // MARK: - Properties

    /// This is a `UIImageView` used to display the image of the content
    @IBOutlet var thumbnail: UIImageView!
    /// This is a `UILabel` used to display title
    @IBOutlet var title: UILabel!
    /// This is a `UILabel` used to display the name of the organizasion who uploads the video
    @IBOutlet var name: UILabel!

    // MARK: - Method

    /// Set up the content
    func set(content: Content) {
        thumbnail.image = content.thumbnail
        title.text = content.title
        name.text = content.channel.name
    }

    // MARK: - View Lifecycle

    /// Prepares a reusable cell for reuse by the table view's delegate.
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = UIImage(named: "Video Placeholder")
        title.text = nil
        name.text = nil
    }
}
