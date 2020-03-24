//
//  testUserModel.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 23/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import XCTest
@testable import x5gon_mobile
class testUserModel: XCTestCase {
    let user = User.generateDefaultUser()
    
    let generateUser = User.init(name: "Felix Hu", profilePic: UIImage.init(named: "pl-angular")!, backgroundImage: UIImage.init(named: "pl-node")!)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDefaultUserName() {
        let name = user.name
        XCTAssertEqual(name, "Patrick Wu")
    }
    
    func testDefaultUserBookmark() {
        let playListGenerated = user.bookmarkedContent
        XCTAssertEqual(playListGenerated.count, 0)
    }
    
    func testDefaultUserProfilePic(){
        let profilPic = user.profilePic
        let checkPic = UIImage.init(named: "profilePic")!
        XCTAssertEqual(profilPic, checkPic)
    }
    
    func testDefaultUserBackGroundImage(){
        let backgroudImage = user.backgroundImage
        let checkImage = UIImage.init(named: "banner")!
        XCTAssertEqual(backgroudImage, checkImage)
    }
    
    func testGeneratedUserName() {
        let name = generateUser.name
        XCTAssertEqual(name, "Felix Hu")
    }
    
    func testGeneratedUserBookmark() {
        let bookmarked = generateUser.bookmarkedContent
        XCTAssertEqual(bookmarked.count, 0)
    }
    
    func testGeneratedUserProfilePic() {
        let profilPic = generateUser.profilePic
        let checkPic = UIImage.init(named: "pl-angular")!
        XCTAssertEqual(profilPic, checkPic)
    }
    
    func testGeneratedUserBackGroundImage(){
        let backgroudImage = generateUser.backgroundImage
        let checkImage = UIImage.init(named: "pl-node")!
        XCTAssertEqual(backgroudImage, checkImage)
    }
    
    func testBookMark(){
        let content = Content.init(title: "Content One", id: 0, channelName: "123", description: "123321", url: URL.init(string: "www.123.com")!)
        user.bookmark(content: content)
        let bool = user.bookmarkedContent.contains(content)
        XCTAssertEqual(bool, true)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
