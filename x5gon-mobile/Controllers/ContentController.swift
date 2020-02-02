//
//  ContentController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 01/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

protocol ContentController {

    static func loadPlaceHolders () -> [ContentModel]
    static func loadDefaultItems()
}

extension ContentController {

    static func fetchItems (keyWord : String, contentType : String) -> [ContentModel] {
        var tmpItems = [ContentModel]()
        let contentURLString = Environment.makeQueryURL(keyWord: keyWord, contentType: contentType)
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
                    if (contentType == "video") {
                        let newVideo = VideoModel.init(title: title, channelName: provider)
                        let newVideoURL = URL.init(string: url)
                        newVideo.initURL(url: newVideoURL!, regenerateInfo: true)
                        tmpItems.append(newVideo)
                    } else if (contentType == "text") {
                        let newPDF = PDFModel.init(title: title, channelName: provider)
                        let newPDFURL = URL.init(string: url)
                        newPDF.initURL(url: newPDFURL!, regenerateInfo: true)
                        tmpItems.append(newPDF)
                    }

                 }
             }
         }
         dataTask.resume()
         semaphore.wait()
         return tmpItems
    }

    
}
