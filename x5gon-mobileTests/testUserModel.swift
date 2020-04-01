//
//  testUserModel.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 23/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

@testable import x5gon_mobile
import XCTest
class testUserModel: XCTestCase {
    let user = User.generateDefaultUser()

    let generateUser = User(name: "Felix Hu", profilePic: UIImage(named: "profilePic")!, backgroundImage: UIImage(named: "banner")!)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDefaultUserName() {
        let name = user.name
        XCTAssert(name.starts(with: "Tmp User #"))
    }

    func testDefaultUserBookmark() {
        let playListGenerated = user.bookmarkedContent
        XCTAssertEqual(playListGenerated.count, 0)
    }

    func testDefaultUserProfilePic() {
        let profilPic = user.profilePic
        let checkPic = UIImage(named: "profilePic")!
        XCTAssertEqual(profilPic, checkPic)
    }

    func testDefaultUserBackGroundImage() {
        let backgroudImage = user.backgroundImage
        let checkImage = UIImage(named: "banner")!
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
        let checkPic = UIImage(named: "profilePic")!
        XCTAssertEqual(profilPic, checkPic)
    }

    func testGeneratedUserBackGroundImage() {
        let backgroudImage = generateUser.backgroundImage
        let checkImage = UIImage(named: "banner")!
        XCTAssertEqual(backgroudImage, checkImage)
    }

    func testBookMark() {
        let content = Content(title: "Content One", id: 0, channelName: "123", description: "123321", url: URL(string: "www.123.com")!)
        user.bookmark(content: content)
        let bool = user.bookmarkedContent.contains(content)
        XCTAssertEqual(bool, true)
    }

    func testUnBookMark() {
        let content = Content(title: "Content One", id: 0, channelName: "123", description: "123321", url: URL(string: "www.123.com")!)
        user.bookmark(content: content)
        user.unbookmark(content: content)
        let bool = user.bookmarkedContent.contains(content)
        XCTAssertEqual(bool, false)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
