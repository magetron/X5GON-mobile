//
//  PDFController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 31/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

class PDFController {
    
    static var items = [PDF]()

    static func loadPlaceHolders () -> [Content] {
        let pdf = PDF.init(title: "Community Meeting 2016", channelName: "Blender Foundation", url: URL.init(string: "https://download.blender.org/institute/sig2016-2.pdf")!)
        return [pdf]
    }
    
    static func loadDefaultItems() {
        let defaultKeyWord = "science"
        let defaultContentType = "text"
        let defaultVideos = API.fetchContents(keyWord: defaultKeyWord, contentType: defaultContentType) as! [PDF]
        items.append(contentsOf: defaultVideos)
        let placeHolders = loadPlaceHolders() as! [PDF]
        items.append(contentsOf: placeHolders)
        items.myShuffle()
    }
    

}
