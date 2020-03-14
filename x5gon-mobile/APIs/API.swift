//
//  API.swift
//  
//
//  Created by Patrick Wu on 11/02/2020.
//

import Foundation
import SwiftSoup

class API {
    /// X5GONAPIAdapter
    static let oldAdapter = X5GONAPIAdapter.self
    ///X5LearnAPIAdapter
    static let newAdapter = X5LearnAPIAdapter.self
    /// AuthenticationToken
    static var authenticationToken = ""
    
    private static func applyAuthToken (request: inout URLRequest) {
        request.addValue(authenticationToken, forHTTPHeaderField: "Authentication-Token")
    }
    
    /**
     Call this function for fetching urls which are returned from X5GON api into a list of our defined type of `Content`
     
     ### Usage Example: ###
     ````
     Api().fetchContents(urlString)
     
     ````
     - Parameter urlString: The urls that can be used to locate the content online
     */
    
    private static func fetchContents (urlString: String) -> [Content] {
        var tmpItems = [Content]()
        let contentURL = URL(string:urlString .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        var request = URLRequest(url: contentURL)
        applyAuthToken(request: &request)
        let semaphore = DispatchSemaphore(value: 0)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            defer { semaphore.signal() }
            tmpItems = parseContents(response: response, data: data)
        }
        dataTask.resume()
        semaphore.wait()
        return tmpItems
    }
    
    private static func parseContents (response: URLResponse?, data: Data?) -> [Content] {
        var tmpItems = [Content]()
        guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
            else {
                print("error: not a valid http response")
                return []
            }
        if (httpResponse.statusCode != 200) {
            print("error: http response \(httpResponse.statusCode) not successful")
        } else {
            let jsonObject = try? JSONSerialization.jsonObject(with: receivedData, options: [])
            guard let materialArray = jsonObject as? [[String:Any]] else {
                print("error: invalid format")
                return []
            }
            for material in materialArray {
                guard let title = material["title"] as? String, let provider = material["provider"] as? String, let url = material["url"] as? String , let mediaType = material["mediatype"] as? String, let id = material["id"] as? Int, let description = material["description"] as? String else {
                        print("error: invalid format")
                        return []
                    }
                if (mediaType == "video" || mediaType == "audio") {
                    let newVideo = Video.init(title: title, id: id, channelName: provider, description: description, url: URL.init(string: url)!)
                    tmpItems.append(newVideo)
                } else if (mediaType == "text") {
                    let newPDF = PDF.init(title: title, id: id, channelName: provider, description: description, url: URL.init(string: url)!)
                    tmpItems.append(newPDF)
                }
            }
        }
        return tmpItems
    }
    
    /**
     Fetching the content using given `keywords` and `contentType` and return a list of `Content`
     
     - Parameters:
        - keyWord: `String` Keyword that used for searching in the X5GON backend
        - contentType: `String` Type of the content, current support format is `audio`,`video`,`text`(This will be converted into pdf)
     
     ### Usage Example: ###
     ````
     API.fetchContents ("science", "pdf")
     ````
     */
    static func fetchContents (keyWord : String, contentType : String) -> [Content] {
        return fetchContents(urlString: newAdapter.generateContentQueryURL(keyWord: keyWord, contentType: contentType))
    }
    
    /**
     Using `featuredURL` to request from X5GON backend and return with a list of `Contents`
     
     ### Usage Example: ###
     ````
     API.fetchFeaturedContents ()
     
     ````
     */
    
    static func fetchFeaturedContents () -> [Content] {
        return fetchContents(urlString: newAdapter.generateFeaturedContentURL())
    }
    
    static func fetchCSRFToken () -> String {
        var csrfToken = ""
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: URL.init(string: newAdapter.generateLoginQueryURL())!) {(data, response, error) in
            defer { semaphore.signal() }
            guard let data = data else { return }
            do {
                let divFields: Elements = try SwiftSoup.parse(String(decoding: data, as: UTF8.self)).body()!.select("div")
                let centreDiv = divFields.array()[1]
                let inputFields = try centreDiv.select("form").first()!.select("input")
                for inputField in inputFields {
                    if inputField.id() == "csrf_token" {
                        csrfToken = try inputField.val()
                    }
                }
            } catch {
                print("error: cannot fetch csrf token")
            }
        }
        task.resume()
        semaphore.wait()
        if (csrfToken == "") {
            print("error: cannot fetch csrf token")
        }
        return csrfToken 
    }
    
    /**
     Logout
     
     ### Usage Example: ###
     ````
     API.logout()
     
     ````
     */
    static func logout () {
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: URL.init(string: newAdapter.gererateLogoutQueryURL())!) { (data, response, error) in
            defer { semaphore.signal() }
            guard data != nil else { return }
            }
        task.resume()
        semaphore.wait()
    }
    
    /**
     Get login authenticationToken
     
     - Parameters:
       - username: Username  type:`String` read from UITextField
       - password:  Passsword type `String` read from UITextField
       - csrfToken:  csrfToken type `String` generated by calling API.csrfToken( )
     - returns:
     login authenticationToken in **String** type
     
     
     ### Usage Example: ###
     ````
     API.fetchLoginTokenWith(username,password,csrfToken)
     ````
     */
    static func fetchLoginTokenWith (username: String, password: String, csrfToken: String) -> String {
        logout()
        var authenticationToken = ""
        var request = URLRequest(url: URL(string: newAdapter.generateLoginQueryURL())!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "email": username,
            "password": password,
            "csrf_token": csrfToken
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("error: \(error.localizedDescription)")
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                guard let response = json["response"] as? [String: Any] else {
                    print("error: invalid format")
                    return
                }
                guard let userInfo = response["user"] as? [String: Any] else {
                    print("error: invalid format")
                    return
                }
                let authToken = userInfo["authentication_token"] as! String
                authenticationToken = authToken
             }
        }

        task.resume()
        semaphore.wait()
        return authenticationToken
    }
    /**
     Fetch `User Json` sent from X5GON backend, to get  user's  login status  ,  name, email  and profile picture
     
     - returns:
    A **User**
     
     
     ### Usage Example: ###
     ````
     API.fetchUser()
     ````
     */
    static func fetchUser () -> User {
        var tmpUser:User?
        let contentURLString = newAdapter.generateUserSessionQueryURL()
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
                guard let loggedInUserInfo = json["loggedInUser"] as? [String: Any] else {
                    print("error: invalid format")
                    return
                }
                guard let userProfile = loggedInUserInfo["userProfile"] as? [String: Any] else {
                    print("error: invalid format")
                    return
                }
                guard let firstName = userProfile["firstName"] as? String, let lastName = userProfile["lastName"] as? String, let email = userProfile["email"] as? String else {
                    print("error: invalid format")
                    return
                }
                tmpUser = User.init(name: firstName + " " + lastName + " " + email, profilePic: UIImage.init(named: "profilePic")!, backgroundImage: UIImage.init(named: "banner")!, playlists: [])
             }
         }
         dataTask.resume()
         semaphore.wait()
         return tmpUser ?? User.generateDefaultUser()
    }
    
    /**
     Fetc
     
     - Parameters:
       - username: Username  type:`String` read from UITextField
       - password:  Passsword type `String` read from UITextField
       - csrfToken:  csrfToken type `String` generated by calling API.csrfToken( )
     - returns:
     login authenticationToken in **String** type
     
     
     ### Usage Example: ###
     ````
     API.fetchLoginTokenWith(username,password,csrfToken)
     ````
     */
    static func DEPRECATED_fetchContents (keyWord: String) -> [Content] {
        var results = [Content]()
        results.append(contentsOf: DEPRECATED_fetchContents(keyWord: keyWord, contentType: "video"))
        results.append(contentsOf: DEPRECATED_fetchContents(keyWord: keyWord, contentType: "pdf"))
        results.append(contentsOf: DEPRECATED_fetchContents(keyWord: keyWord, contentType: "audio"))
        return results.shuffled()
    }
    
    static func DEPRECATED_fetchContents (keyWord : String, contentType : String) -> [Content] {
        var tmpItems = [Content]()
        let contentURLString = oldAdapter.generateContentQueryURL(keyWord: keyWord, contentType: contentType)
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
                    guard let title = material["title"] as? String, let provider = material["provider"] as? [String : Any], let url = material["url"] as? String
                    else {
                        print("error: invalid format")
                        break
                    }
                    guard let providerName = provider["name"] as? String
                        else {
                            print("error: invalid format")
                            break
                    }
                    if (contentType == "video" || contentType == "audio") {
                        let newVideo = Video.init(title: title, id: 0, channelName: providerName, description: "", url: URL.init(string: url)!)
                        tmpItems.append(newVideo)
                    } else if (contentType == "text") {
                        let newPDF = PDF.init(title: title, id: 0, channelName: providerName, description: "", url: URL.init(string: url)!)
                        tmpItems.append(newPDF)
                    }
                 }
             }
         }
         dataTask.resume()
         semaphore.wait()
         return tmpItems
    }
    
    static func fetchWikiChunkEnrichments (ids: [Int]) -> Wiki {
        var tmpWiki: Wiki?
        var request = URLRequest(url: URL(string: newAdapter.generateWikiChunkEnrichmentsURL())!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        applyAuthToken(request: &request)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "ids": ids
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("error: \(error.localizedDescription)")
        }
        let semaphore = DispatchSemaphore(value: 0)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
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
                guard let json = jsonObject as? [[String: Any]] else { print("error: invalid format"); return }
                if (json.count == 0) {
                    print("error: invalid format");
                    return
                }
                guard let chunks = json[0]["chunks"] as? [[String: Any]] else { print("error: invalid format"); return }
                var chunkArr = [WikiChunk]()
                for chunk in chunks {
                    guard let entities = chunk["entities"] as? [[String: Any]] else { print("error: invalid format"); return }
                    var entityArr = [WikiEntity]()
                    for entity in entities {
                        guard let id = entity["id"] as? String, let title = entity["title"] as? String, let url = entity["url"] as? String else { print("error: invalid format"); return }
                        let tmpEntity = WikiEntity.init(id: id, title: title, url: URL.init(string: url)!)
                        entityArr.append(tmpEntity)
                    }
                    guard let length = chunk["length"] as? Double, let start = chunk["start"] as? Double, let text = chunk["text"] as? String else { print("error: invalid format"); return }
                    let tmpChunk = WikiChunk.init(entities: entityArr, length: length, start: start, text: text)
                    chunkArr.append(tmpChunk)
                }
                tmpWiki = Wiki.init(chunks: chunkArr)
            }
        }
        dataTask.resume()
        semaphore.wait()
        return tmpWiki ?? Wiki.init(chunks: [])
    }
}
