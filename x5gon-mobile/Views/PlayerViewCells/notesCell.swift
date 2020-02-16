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
    

    @IBOutlet weak var noteView: UITextView!
    @IBOutlet weak var noteViewHC: NSLayoutConstraint!
    
    func customisation () {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapMarkdownView))
//        self.addGestureRecognizer(tap)
    }
//
//    @objc func tapMarkdownView(sender: UITapGestureRecognizer) {
//        self.notesView.clearSubViews()
//        editTextView.frame = notesView.frame
//        notesView.addSubview(editTextView)
//        editTextView.centreView(parentView: notesView)
//        editTextView.isEditable = true
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapeditTextView))
//        self.addGestureRecognizer(tap)
////        self.reloadInputViews()
//    }
//
//    @objc func tapeditTextView(sender: UITapGestureRecognizer) {
//        self.notesView.clearSubViews()
//        editTextView.insertText("\nPut some **Markdown** notes here.")
//        buildMarkDownView()
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapMarkdownView))
//        self.addGestureRecognizer(tap)
//    //        self.reloadInputViews()
//    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
//    func buildMarkDownView(){
//        markDownView = try! DownView.init(frame: self.notesView.frame, markdownString: editTextView.text)
//        markDownView!.frame = notesView.frame
//        notesView.addSubview(markDownView!)
//        markDownView!.centreView(parentView: notesView)
//    }
//
    
    func textViewDidChange(_ textView: UITextView) {
        noteViewHC.constant = self.noteView.contentSize.height
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
