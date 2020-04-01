//
//  notesCell.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 04/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

/// Note cell is used for user to put note
class notesCell: UITableViewCell, UITextViewDelegate {
    let defaultString = "Write Your Note Here"

    // MARK: - Properties

    /// This is a `UITextView` to put the note
    @IBOutlet var textView: UITextView!
    var contentId = 0

    // MARK: - Methods

    /// Cutomise the cell
    func customisation() {
        textView.isScrollEnabled = true
        textView.text = ""
        textView.textColor = UIColor.lightGray
        textView.returnKeyType = .done
        textView.delegate = self
    }

    /// Set the note cell
    func set(text: String, id: Int) {
        textView.text = text
        if text == "" {
            textView.text = "Write Your Note Here"
            textView.textColor = UIColor.lightGray
        }
        contentId = id
    }

    // MARK: - Delegates

    /**
     Tells the delegate that editing of the specified text view has begun.

     - Parameters:
        - textView: The text view in which editing began.

     */
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == defaultString {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }

    /**
     Asks the delegate whether the specified text should be replaced in the text view.

     - Parameters:
        - textView: The text view containing the changes.
        - shouldChangeTextIn: The current selection range. If the length of the range is 0, range reflects the current insertion point. If the user presses the Delete key, the length of the range is 1 and an empty string object replaces that single character.
        - replacementText: The text to insert.
     - returns:
     `true` if the old text should be replaced by the new text; false if the replacement operation should be aborted.

     */
    func textView(_ textView: UITextView, shouldChangeTextIn _: NSRange, replacementText _: String) -> Bool {
        if textView.text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    /**
     Tells the delegate that editing of the specified text view has ended.

     - Parameter textView: The text view in which editing ended.
     */
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Write Your Note Here"
            textView.textColor = UIColor.lightGray
        }
        textView.sizeToFit()
        for constraint in self.textView.constraints {
            if constraint.identifier == "textViewHC" {
                constraint.constant = self.textView.contentSize.height
            }
        }
        MainController.createNotes(id: contentId, text: textView.text)
        MainController.navViewController?.playerView.tableView.reloadDataWithAnimation()
    }

    // MARK: - View Lifecycle

    /// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }

    /// Prepares a reusable cell for reuse by the table view's delegate.
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
