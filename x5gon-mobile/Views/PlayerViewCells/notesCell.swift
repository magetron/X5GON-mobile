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
        buildMarkDownView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapMarkdownView))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapMarkdownView(sender: UITapGestureRecognizer) {
        self.notesView.clearSubViews()
        editTextView.frame = notesView.frame
        notesView.addSubview(editTextView)
        editTextView.centreView(parentView: notesView)
        editTextView.isEditable = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapeditTextView))
        self.addGestureRecognizer(tap)
//        self.reloadInputViews()
    }
    
    @objc func tapeditTextView(sender: UITapGestureRecognizer) {
        self.notesView.clearSubViews()
        editTextView.insertText("\nPut some **Markdown** notes here.")
        buildMarkDownView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapMarkdownView))
        self.addGestureRecognizer(tap)
    //        self.reloadInputViews()
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func buildMarkDownView(){
        markDownView = try! DownView.init(frame: self.notesView.frame, markdownString: editTextView.text)
        markDownView!.frame = notesView.frame
        notesView.addSubview(markDownView!)
        markDownView!.centreView(parentView: notesView)
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
