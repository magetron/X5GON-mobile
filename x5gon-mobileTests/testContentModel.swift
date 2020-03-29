//
//  testContentModel.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 23/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import XCTest
@testable import x5gon_mobile
class testContentModel: XCTestCase {
    let content = Content.init(title: "Test Content", id: 111, channelName: "Test Channel", description: "This is our test Content", url: URL.init(string: "www.testContent.com")!)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testContentTitle(){
        let title = content.title
        XCTAssertEqual(title, "Test Content")
    }
    
    func testContentID(){
        let id = content.id
        XCTAssertEqual(id, 111)
    }
    
    func testContentChannel(){
        let channel = content.channel.name
        XCTAssertEqual(channel, "Test Channel")
    }
    
    func testContentURL(){
        let url = content.contentLink
        let testUrl = URL.init(string: "www.testContent.com")!
        XCTAssertEqual(url, testUrl)
    }
    
    func testContentDescription(){
        let description = content.description
        XCTAssertEqual(description, "This is our test Content")
    }
    
    func testContentDuration(){
        let duration = content.duration
        XCTAssertEqual(duration, 0)
    }
    
    func testContentViews(){
        let view = content.views
        let bool = view < 1000000
        XCTAssertTrue(bool)
    }
    
    func testContentThumbnail(){
        let thumbnailCheck = UIImage.init(named: "Video Placeholder")!
        XCTAssertEqual(content.thumbnail, thumbnailCheck)
    }

    func testLikeContent() {
        let int = Int.random(in: 2..<20)
        for _ in 1...int{
            content.like()
        }
        XCTAssertEqual(content.likes, int)
    }
    
    func testDisLikeContent() {
        let int = Int.random(in: 2..<20)
        for _ in 1...int{
            content.dislike()
        }
        XCTAssertEqual(content.disLikes, int)
    }
    
    func testFetchContentInfo(){
        expectFatalError(expectedMessage: "error: directly calling content generateContentInfo()") {
            self.content.fetchContentInfo()
        }
    }
    
    func testfetchSuggestedContents(){
        expectFatalError(expectedMessage: "error: directly calling content fetchSuggestedContents()") {
            self.content.fetchSuggestedContents()
        }
    }
    
    func testSelfDefinedEqual(){
        let contentTest = Content.init(title: "Test Content", id: 113, channelName: "Test Channel", description: "This is our test Content", url: URL.init(string: "www.testContent.com")!)
        let result = content == contentTest
        XCTAssertFalse(result)
    }
    
    func testHash(){
        var hasher = Hasher()
        content.hash(into: &hasher)
        XCTAssertEqual(content.id, 111)
    }
    
    func testFetchWikiChunkEnrichments(){
        let wiki = content.fetchWikiChunkEnrichments()
        XCTAssertNotNil(wiki)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
