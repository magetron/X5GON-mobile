//
//  notesCell.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 04/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit
import Down

class notesCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var notesView: UIView!
    var editTextView = UITextView()
    var markDownView:UIView?
    
    func customisation () {
        editTextView.text = "Put some **Markdown** notes here."
        markDownView = try! DownView.init(frame: self.notesView.frame, markdownString: editTextView.text)
        markDownView!.frame = notesView.frame
        notesView.addSubview(markDownView!)
        markDownView!.centreView(parentView: notesView)
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapMarkdownView))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapMarkdownView(sender: UITapGestureRecognizer) {
        self.notesView.clearSubViews()
        notesView.addSubview(editTextView)
        editTextView.centreView(parentView: notesView)
        self.reloadInputViews()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.notesView.clearSubViews()
        let mdView = markDownView as! DownView
        try? mdView.update(markdownString: textView.text) {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
