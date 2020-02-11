//
//  VideoController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 31/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation


class VideoController {
    
    static var items = [Video]()

    static func loadPlaceHolders () -> [Content] {
        let playableVideo = Video.init(title: "Big Buck Bunny", channelName: "Blender Foundation", url: URL.init(string: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4")!)
        return [playableVideo]
    }
    
    static func loadDefaultItems() {
        let defaultKeyWord = "science"
        let defaultContentType = "video"
        let defaultVideos = API.fetchContents(keyWord: defaultKeyWord, contentType: defaultContentType) as! [Video]
        items.append(contentsOf: defaultVideos)
        let placeHolders = loadPlaceHolders() as! [Video]
        items.append(contentsOf: placeHolders)
        items.myShuffle()
    }
    

}
