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
    
    func customisation () {
        textView.isScrollEnabled = true
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
        if textView.text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.text = "Write Your Note Here"
            textView.textColor = UIColor.lightGray
        }
        textView.sizeToFit()
        for constraint in self.textView.constraints{
            if constraint.identifier == "textViewHC"{
                constraint.constant = self.textView.contentSize.height
            }
        }
        MainController.navViewController?.playerView.tableView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
