//
//  PDFModel.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 31/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit


class PDFModel : ContentModel {
    override func fetchSuggestedContents (async : Bool, refresher: @escaping () -> Void) {
         if (async) {
             DispatchQueue.global().async {
                 let pdfs = PDFController.fetchItems(keyWord: self.title, contentType: "text")
                 super.suggestedContents = pdfs
                 OperationQueue.main.addOperation ({
                      refresher()
                 })
             }
         } else {
             let pdfs = PDFController.fetchItems(keyWord: self.title, contentType: "text")
             self.suggestedContents = pdfs
         }
     }
     
     override func generateInfo() {
        self.duration = 0
     }
    
}

