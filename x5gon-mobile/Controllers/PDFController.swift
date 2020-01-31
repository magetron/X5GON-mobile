//
//  PDFController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 31/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

class PDFController {
    
    static var items = [PDFModel]()

    static func loadPlaceHolders () -> [PDFModel] {
        let pdf = PDFModel.init(title: "A PDF File", channelName: "Blender Foundation")
        return [pdf]
    }
    
    static func fetchItems (keyWord : String, contentType : String) -> [PDFModel] {
        var tmpItems = [PDFModel]()
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
                    let newPDF = PDFModel.init(title: title, channelName: provider)
                    let newPDFURL = URL.init(string: url)
                    newPDF.initURL(url: newPDFURL!, regenerateInfo: true)
                    tmpItems.append(newPDF)
                }
            }
        }
        dataTask.resume()
        semaphore.wait()
        return tmpItems
    }
    
    
    static func loadItems() {
        let defaultKeyWord = "science"
        let defaultContentType = "pdf"
        let defaultVideos = fetchItems(keyWord: defaultKeyWord, contentType: defaultContentType)
        items.append(contentsOf: defaultVideos)
        let placeHolders = loadPlaceHolders()
        items.append(contentsOf: placeHolders)
        items.myShuffle()
    }
    

}
