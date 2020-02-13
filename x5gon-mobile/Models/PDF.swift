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
    
    override init (title: String, channelName: String, url: URL) {
        super.init(title: title, channelName: channelName, url: url)
        self.fetchContentInfo()
    }
    
    override func fetchSuggestedContents (refresher: @escaping () -> Void) {
        DispatchQueue.global().async {
            let pdfs = API.fetchContents(keyWord: self.title, contentType: "text")
            super.suggestedContents = pdfs
            OperationQueue.main.addOperation ({
                refresher()
            })
        }
    }
     
    override func fetchContentInfo() {
        self.duration = 0
    }
    
}

