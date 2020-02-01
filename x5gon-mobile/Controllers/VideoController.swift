//
//  VideoController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 31/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation


class VideoController : ContentController{
    
    static var items = [VideoModel]()

    static func loadPlaceHolders () -> [ContentModel] {
        let playableVideo = VideoModel.init(title: "Big Buck Bunny", channelName: "Blender Foundation")
        playableVideo.videoLink = URL.init(string: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4")!
        let suggestedVideo1 = VideoModel.init(title: "What Does Jared Kushner Believe", channelName: "Nerdwriter1")
        let suggestedVideo2 = VideoModel.init(title: "Moore's Law Is Ending. So, What's Next", channelName: "Seeker")
        let suggestedVideo3 = VideoModel.init(title: "What Bill Gates is afraid of", channelName: "Vox")
        let suggestedVideo4 = VideoModel.init(title: "Why Can't America Have a Grown-Up Healthcare Conversation", channelName: "vlogbrothers")
        let suggestedVideo5 = VideoModel.init(title: "TensorFlow Basics - Deep Learning with Neural Networks p. 2", channelName: "sentdex")
        let suggestedItems = [suggestedVideo1, suggestedVideo2, suggestedVideo3, suggestedVideo4, suggestedVideo5]
        playableVideo.suggestedContents = suggestedItems
        
        let video1 = VideoModel.init(title: "What Does Jared Kushner Believe", channelName: "Nerdwriter1")
        let video2 = VideoModel.init(title: "Moore's Law Is Ending. So, What's Next", channelName: "Seeker")
        let video3 = VideoModel.init(title: "What Bill Gates is afraid of", channelName: "Vox")
        let video4 = VideoModel.init(title: "Why Can't America Have a Grown-Up Healthcare Conversation", channelName: "vlogbrothers")
        let video5 = VideoModel.init(title: "A New History for Humanity – The Human Era", channelName: "Kurzgesagt – In a Nutshell")
        let video6 = VideoModel.init(title: "Neural Network that Changes Everything - Computerphile", channelName: "Computerphile")
        let video7 = VideoModel.init(title: "TensorFlow Basics - Deep Learning with Neural Networks p. 2", channelName: "sentdex")
        let video8 = VideoModel.init(title: "Scott Galloway: The Retailer Growing Faster Than Amazon", channelName: "L2inc")
        return [playableVideo, video1, video2, video3, video4, video5, video6, video7, video8]
    }
    
    static func loadDefaultItems() {
        let defaultKeyWord = "science"
        let defaultContentType = "video"
        let defaultVideos = fetchItems(keyWord: defaultKeyWord, contentType: defaultContentType) as! [VideoModel]
        items.append(contentsOf: defaultVideos)
        let placeHolders = loadPlaceHolders() as! [VideoModel]
        items.append(contentsOf: placeHolders)
        items.myShuffle()
    }
    

}
