//
//  testWikiEntity.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 23/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import XCTest
@testable import x5gon_mobile
class testWikiEntity: XCTestCase {
    let wiki = WikiEntity.init(id: "Test WikiEntity", title: "Title", url: URL.init(string: "www.testWiki.com")!)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWikiEntityId(){
        let id = wiki.id
        XCTAssertEqual(id, "Test WikiEntity")
    }
    
    func testWikiEntityTitle(){
        let title = wiki.title
        XCTAssertEqual(title, "Title")
    }
    
    func testWikiEntityUrl(){
        let url = wiki.url
        let testURL = URL.init(string: "www.testWiki.com")!
        XCTAssertEqual(url, testURL)
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
