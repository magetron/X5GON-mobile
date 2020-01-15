//
//  VideoModel.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class VideoModel {
    
    //MARK: Properties
    let thumbnail: UIImage
    let title: String
    let views: Int
    let channel: Channel
    let duration: Int
    var videoLink: URL!
    let likes: Int
    let disLikes: Int
    var suggestedVideos = [SuggestedVideo]()
    
    //MARK: Inits
    init(title: String, channelName: String) {
        self.thumbnail = UIImage.init(named: title)!
        self.title = title
        self.views = Int(arc4random_uniform(1000000))
        self.duration = Int(arc4random_uniform(400))
        self.likes = Int(arc4random_uniform(1000))
        self.disLikes = Int(arc4random_uniform(1000))
        self.channel = Channel.init(name: channelName, image: UIImage.init(named: channelName)!)
    }
    
    //MARK: Methods
    class func fetchVideos(completion: @escaping (([VideoModel]) -> Void)) {
        let video1 = VideoModel.init(title: "Computer Architecture", channelName: "Prof Martin Hiels")
        let video2 = VideoModel.init(title: "Getting start with java", channelName: "Seeker")
        let video3 = VideoModel.init(title: "What is Chemistry", channelName: "Prof Jhon Alexans")
        let video4 = VideoModel.init(title: "Math,this is a science", channelName: "vlogbrothers")
        let video5 = VideoModel.init(title: "10 hints before coding", channelName: "Kurzgesagt – In a Nutshell")
        let video6 = VideoModel.init(title: "Neural Network that Changes Everything - Computerphile", channelName: "Computerphile")
        let video7 = VideoModel.init(title: "TensorFlow Basics - Deep Learning with Neural Networks p. 2", channelName: "sentdex")
        let video8 = VideoModel.init(title: "Scott Galloway: The Retailer Growing Faster Than Amazon", channelName: "L2inc")
        var items = [video1, video2, video3, video4, video5, video6, video7, video8]
        items.myShuffle()
        completion(items)
    }
    
    class func fetchVideo(completion: @escaping ((VideoModel) -> Void)) {
        let video = VideoModel.init(title: "Big Buck Bunny", channelName: "Blender Foundation")
        video.videoLink = URL.init(string: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4")!
        let suggestedVideo1 = SuggestedVideo.init(title: "Computer Architecture", channelName: "Prof Martin Hiels")
        let suggestedVideo2 = SuggestedVideo.init(title: "Getting start with java", channelName: "Seeker")
        let suggestedVideo3 = SuggestedVideo.init(title: "What is Chemistry", channelName: "Prof Jhon Alexans")
        let suggestedVideo4 = SuggestedVideo.init(title: "Math,this is a science", channelName: "vlogbrothers")
        let suggestedVideo5 = SuggestedVideo.init(title: "TensorFlow Basics - Deep Learning with Neural Networks p. 2", channelName: "sentdex")
        let items = [suggestedVideo1, suggestedVideo2, suggestedVideo3, suggestedVideo4, suggestedVideo5]
        video.suggestedVideos = items
        completion(video)
    }
}

struct SuggestedVideo {
    
    let title: String
    let channelName: String
    let thumbnail: UIImage
    
    init(title: String, channelName:String) {
        self.title = title
        self.channelName = channelName
        self.thumbnail = UIImage.init(named: title)!
    }
}

class Channel {
    
    let name: String
    let image: UIImage
    var subscribers = 0
    
    class func fetchData(completion: @escaping (([Channel]) -> Void)) {
        var items = [Channel]()
        for i in 0...18 {
            let name = ""
            let image = UIImage.init(named: "channel\(i)")
            let channel = Channel.init(name: name, image: image!)
            items.append(channel)
        }
        items.myShuffle()
        completion(items)
    }

    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}

