//
//  testPdfModel.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 23/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

@testable import x5gon_mobile
import XCTest
class testPdfModel: XCTestCase {
    let pdf = PDF(title: "Test Pdf", id: 111, channelName: "Test Channel", description: "This is our test Pdf", url: URL(string: "www.testPdf.com")!)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPdfTitle() {
        let title = pdf.title
        XCTAssertEqual(title, "Test Pdf")
    }

    func testPdfID() {
        let id = pdf.id
        XCTAssertEqual(id, 111)
    }

    func testPdfChannel() {
        let channel = pdf.channel.name
        XCTAssertEqual(channel, "Test Channel")
    }

    func testPdfURL() {
        let url = pdf.contentLink
        let testUrl = URL(string: "www.testPdf.com")!
        XCTAssertEqual(url, testUrl)
    }

    func testPdfDescription() {
        let description = pdf.description
        XCTAssertEqual(description, "This is our test Pdf")
    }

    func testPdfDuration() {
        let duration = pdf.duration
        XCTAssertEqual(duration, 0)
    }

    func testPdfViews() {
        let view = pdf.views
        let bool = view < 1_000_000
        XCTAssertTrue(bool)
    }

    func testPdfThumbnail() {
        let thumbnailCheck = UIImage(named: "Video Placeholder")!
        XCTAssertEqual(pdf.thumbnail, thumbnailCheck)
    }

    func testLikePdf() {
        let int = Int.random(in: 2 ..< 15)
        for _ in 1 ... int {
            pdf.like()
        }
        XCTAssertEqual(pdf.likes, int)
    }

    func testDisLikePdf() {
        let int = Int.random(in: 2 ..< 15)
        for _ in 1 ... int {
            pdf.dislike()
        }
        XCTAssertEqual(pdf.disLikes, int)
    }

    func testPdfFetchContentInfo() {
        let int = pdf.duration
        XCTAssertEqual(int, 0)
    }

    func testPdfFetchSuggestionContents() {
        cancellableRefresher(updateContent: { self.pdf.fetchSuggestedContents() }, viewReload: {})
        MainController.Queue.cancelOperations()
        XCTAssertNotNil(pdf.suggestedContents)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
