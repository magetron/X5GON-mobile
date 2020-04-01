//
//  testPlaylistModel.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 23/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

@testable import x5gon_mobile
import XCTest
class testPlaylistModel: XCTestCase {
    let playList = Playlist(pic: UIImage(named: "banner")!, title: "This is title", numberOfVideos: 10)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPlayListNum() {
        let testNum = playList.numberOfVideos
        XCTAssertEqual(testNum, 10)
    }

    func testPlayListTitle() {
        let title = playList.title
        XCTAssertEqual(title, "This is title")
    }

    func testPlayListImage() {
        let testImage = UIImage(named: "banner")!
        let bool = (testImage == playList.pic)
        XCTAssertTrue(bool)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
