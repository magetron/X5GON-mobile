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
    func customisation () {
        textView.text = "Write Your Note Here"
        textView.textColor = UIColor.lightGray
        textView.returnKeyType = .done
        textView.delegate = self
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write Your Note Here"{
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("called textview")
        if textView.text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("did end editing ")
        if textView.text == ""{
            textView.text = "Write Your Note Here"
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
