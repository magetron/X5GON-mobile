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

    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        noteViewHC.constant = self.noteView.contentSize.height
    }
    
//    func buildMarkDownView(){
//        markDownView = try! DownView.init(frame: self.notesView.frame, markdownString: editTextView.text)
//        markDownView!.frame = notesView.frame
//        notesView.addSubview(markDownView!)
//        markDownView!.centreView(parentView: notesView)
//    }
//
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.noteView.resignFirstResponder()
   //     noteViewHC.constant = self.noteView.contentSize.height
        noteViewHC.constant = self.noteView.contentSize.height
        print(self.noteView.contentSize.height)
        print("end texting")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
