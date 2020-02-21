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
    
    override init (title: String, id: Int, channelName: String, description: String, url: URL) {
        super.init(title: title, id: id, channelName: channelName, description: description, url: url)
        self.fetchContentInfo()
    }
    
    override func fetchSuggestedContents () {
        let pdfs = API.fetchContents(keyWord: self.title, contentType: "text")
        super.suggestedContents = pdfs
    }
     
    override func fetchContentInfo() {
        self.duration = 0
    }
    
}

