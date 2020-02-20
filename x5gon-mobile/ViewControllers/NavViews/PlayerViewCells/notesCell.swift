//
//  notesCell.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 04/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class notesCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var textViewHC: NSLayoutConstraint!
    var textHolder = ""
    func customisation () {
        textView.text = "Write Your Note Here \n"
        textView.textColor = UIColor.lightGray
        textView.returnKeyType = .done
        textView.delegate = self
        textViewHC.constant = self.textView.contentSize.height
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write Your Note Here \n"{
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.text = "Write Your Note Here \n"
            textView.textColor = UIColor.lightGray
        }
        textViewHC.constant = self.textView.contentSize.height
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
