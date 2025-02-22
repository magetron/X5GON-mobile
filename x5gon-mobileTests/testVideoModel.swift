//
//  testVideoModel.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 23/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

@testable import x5gon_mobile
import XCTest
class testVideoModel: XCTestCase {
    let video = Video(title: "Test video", id: 111, channelName: "Test Channel", description: "This is our test video", url: URL(string: "www.testvideo.com")!)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testVideoTitle() {
        let title = video.title
        XCTAssertEqual(title, "Test video")
    }

    func testVideoID() {
        let id = video.id
        XCTAssertEqual(id, 111)
    }

    func testVideoChannel() {
        let channel = video.channel.name
        XCTAssertEqual(channel, "Test Channel")
    }

    func testVideoURL() {
        let url = video.contentLink
        let testUrl = URL(string: "www.testvideo.com")!
        XCTAssertEqual(url, testUrl)
    }

    func testVideoDescription() {
        let description = video.description
        XCTAssertEqual(description, "This is our test video")
    }

    func testVideoDuration() {
        let duration = video.duration
        XCTAssertEqual(duration, 0)
    }

    func testVideoViews() {
        let view = video.views
        let bool = view < 1_000_000
        XCTAssertTrue(bool)
    }

    func testVideoThumbnail() {
        let thumbnailCheck = UIImage(named: "Video Placeholder")!
        XCTAssertEqual(video.thumbnail, thumbnailCheck)
    }

    func testLikeVideo() {
        let int = Int.random(in: 2 ..< 10)
        for _ in 1 ... int {
            video.like()
        }
        XCTAssertEqual(video.likes, int)
    }

    func testDisLikeVideo() {
        let int = Int.random(in: 2 ..< 10)
        for _ in 1 ... int {
            video.dislike()
        }
        XCTAssertEqual(video.disLikes, int)
    }

    func testFetchSuggestionContent() {
        cancellableRefresher(updateContent: { self.video.fetchSuggestedContents() }, viewReload: {})
        MainController.Queue.cancelOperations()
        XCTAssertNotNil(video.suggestedContents)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
