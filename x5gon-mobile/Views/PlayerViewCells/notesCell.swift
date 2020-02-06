//
//  notesCell.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 04/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit
import MarkdownKit
class notesCell: UITableViewCell, UITextViewDelegate {
    let markDownParser = MarkdownParser()
    let sampleString = "**iosprogramming** can be *markdown* as well!" //for test
    @IBOutlet weak var textView: UITextView!
    
    func customisation () {
        self.textView.sizeToFit()
        self.textView.attributedText = markDownParser.parse(sampleString)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
