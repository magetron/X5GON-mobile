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


class PDF : Content {
    
    override func fetchSuggestedContents (refresher: @escaping () -> Void) {
         DispatchQueue.global().async {
             let pdfs = API.fetchContents(keyWord: self.title, contentType: "text")
             super.suggestedContents = pdfs
             OperationQueue.main.addOperation ({
                  refresher()
             })
         }
     }
     
     override func generateContentInfo() {
        self.duration = 0
     }
    
}

