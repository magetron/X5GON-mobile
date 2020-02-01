//
//  PDFController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 31/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

class PDFController : ContentController {
    
    static var items = [PDFModel]()

    static func loadPlaceHolders () -> [ContentModel] {
        let pdf = PDFModel.init(title: "A PDF File", channelName: "Blender Foundation")
        return [pdf]
    }
    
    static func loadDefaultItems() {
        let defaultKeyWord = "science"
        let defaultContentType = "context"
        let defaultVideos = fetchItems(keyWord: defaultKeyWord, contentType: defaultContentType) as! [PDFModel]
        items.append(contentsOf: defaultVideos)
        let placeHolders = loadPlaceHolders() as! [PDFModel]
        items.append(contentsOf: placeHolders)
        items.myShuffle()
    }
    

}
