//
//  PDFController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 31/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

class PDFController : ContentController {
    
    static var items = [PDF]()

    static func loadPlaceHolders () -> [Content] {
        let pdf = PDF.init(title: "A PDF File", channelName: "Blender Foundation")
        return [pdf]
    }
    
    static func loadDefaultItems() {
        let defaultKeyWord = "science"
        let defaultContentType = "text"
        let defaultVideos = fetchItems(keyWord: defaultKeyWord, contentType: defaultContentType) as! [PDF]
        items.append(contentsOf: defaultVideos)
        let placeHolders = loadPlaceHolders() as! [PDF]
        items.append(contentsOf: placeHolders)
        items.myShuffle()
    }
    

}
