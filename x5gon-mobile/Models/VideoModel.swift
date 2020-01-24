//
//  VideoModel.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class Videos {
    
    static var items = [VideoModel]()

    static func loadPlaceHolders () -> [VideoModel] {
        let playableVideo = VideoModel.init(title: "Big Buck Bunny", channelName: "Blender Foundation")
        playableVideo.videoLink = URL.init(string: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4")!
        let suggestedVideo1 = VideoModel.init(title: "What Does Jared Kushner Believe", channelName: "Nerdwriter1")
        let suggestedVideo2 = VideoModel.init(title: "Moore's Law Is Ending. So, What's Next", channelName: "Seeker")
        let suggestedVideo3 = VideoModel.init(title: "What Bill Gates is afraid of", channelName: "Vox")
        let suggestedVideo4 = VideoModel.init(title: "Why Can't America Have a Grown-Up Healthcare Conversation", channelName: "vlogbrothers")
        let suggestedVideo5 = VideoModel.init(title: "TensorFlow Basics - Deep Learning with Neural Networks p. 2", channelName: "sentdex")
        let suggestedItems = [suggestedVideo1, suggestedVideo2, suggestedVideo3, suggestedVideo4, suggestedVideo5]
        playableVideo.suggestedVideos = suggestedItems
        
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
    
    static func fetchItems (keyWord : String, contentType : String) -> [VideoModel] {
        var tmpItems = [VideoModel]()
        let contentURLString = "https://platform.x5gon.org/api/v1/recommend/oer_materials?text=\"" + keyWord + "\"&type=" + contentType
        let contentURL = URL(string: contentURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        let semaphore = DispatchSemaphore(value: 0)
        let dataTask = URLSession.shared.dataTask(with: contentURL) { data, response, error in
            defer { semaphore.signal() }
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
                else {
                    print("error: not a valid http response")
                    return
                }
            if (httpResponse.statusCode != 200) {
                print("error: http response \(httpResponse.statusCode) not successful")
            } else {
                let jsonObject = try? JSONSerialization.jsonObject(with: receivedData, options: [])
                guard let json = jsonObject as? [String: Any] else {
                    print("error: invalid format")
                    return
                }
                guard let recommendationMaterials = json["rec_materials"] as? [[String: Any]] else {
                    print("error: invalid format")
                    return
                }
                for material in recommendationMaterials {
                    guard let title = material["title"] as? String, let provider = material["provider"] as? String, let url = material["url"] as? String
                    else {
                        print("error: invalid format")
                        break
                    }
                    let newVideo = VideoModel.init(title: title, channelName: provider)
                    let newVideoURL = URL.init(string: url)
                    newVideo.initURL(url: newVideoURL!, regenerateInfo: true)
                    tmpItems.append(newVideo)
                }
            }
        }
        dataTask.resume()
        semaphore.wait()
        return tmpItems
    }
    
    
    static func loadItems() {
        let defaultKeyWord = "science"
        let defaultContentType = "video"
        let defaultVideos = fetchItems(keyWord: defaultKeyWord, contentType: defaultContentType)
        items.append(contentsOf: defaultVideos)
        let placeHolders = loadPlaceHolders()
        items.append(contentsOf: placeHolders)
        items.myShuffle()
    }
    

}


class VideoModel {
    
    //MARK: Properties
    var thumbnail: UIImage
    let title: String
    let views: Int
    let channel: ChannelModel
    var duration: Int
    var videoLink: URL!
    var likes: Int
    var disLikes: Int
    var suggestedVideos = [VideoModel]()
        
    //MARK: Inits
    init(title: String, channelName: String) {
        self.thumbnail = UIImage.init(named: title) ?? UIImage.init(named: "Video Placeholder")!
        self.title = title
        self.views = Int(arc4random_uniform(1000000))
        self.duration = Int(arc4random_uniform(400))
        self.likes = Int(arc4random_uniform(1000))
        self.disLikes = Int(arc4random_uniform(1000))
        self.channel = ChannelModel.init(name: channelName, image: UIImage.init(named: channelName) ?? UIImage.init(named: "Channel Placeholder")!)
    }
    
    func initURL (url : URL, regenerateInfo : Bool) {
        self.videoLink = url
        if (regenerateInfo) {
            generateInfo()
        }
    }
    
    func fetchSuggestedVideos (async : Bool, refresher: @escaping () -> Void) {
        if (async) {
            DispatchQueue.global().async {
                let videos = Videos.fetchItems(keyWord: self.title, contentType: "video")
                self.suggestedVideos = videos
                OperationQueue.main.addOperation ({
                     refresher()
                })
            }
        } else {
            let videos = Videos.fetchItems(keyWord: self.title, contentType: "video")
            self.suggestedVideos = videos
        }
    }
    
    func generateInfo() {
        AVAsset(url: videoLink).generateThumbnail { [weak self] (image, duration) in
            DispatchQueue.main.async {
                guard let image = image, let duration = duration else {
                    return
                }
                self?.thumbnail = image
                self?.duration = duration
            }
        }
    }
    
}

class ChannelModel {
    
    let name: String
    let image: UIImage
    var subscribers = 0
    
    class func fetchData(completion: @escaping (([ChannelModel]) -> Void)) {
        var items = [ChannelModel]()
        for i in 0...18 {
            let name = ""
            let image = UIImage.init(named: "channel\(i)")
            let channel = ChannelModel.init(name: name, image: image!)
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
