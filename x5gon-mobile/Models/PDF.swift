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
    /// Performe `PDF` initialization
    override init (title: String, id: Int, channelName: String, description: String, url: URL) {
        super.init(title: title, id: id, channelName: channelName, description: description, url: url)
        self.fetchContentInfo()
    }
    
    /// Fetching content using **text(pdf)** as contentType
    override func fetchSuggestedContents () {
        let pdfs = MainController.fetchContents(keyWord: self.title, contentType: "text", cancellable: true)
        super.suggestedContents = pdfs
    }
    
    /**
     Fetching `Content` information
     
     ### Usage Example: ###
     ````
      self.fetchContentInfo()
     ````
     */    override func fetchContentInfo() {
        self.duration = 0
    }
    
}

