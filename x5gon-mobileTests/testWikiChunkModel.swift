//
//  testWikiChunkModel.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 29/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import XCTest
@testable import x5gon_mobile
class testWikiChunkModel: XCTestCase {
    

    override func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWikiChunkInit() {
        var entityArr = [WikiEntity]()
        let tmpEntity = WikiEntity.init(id: "Test WikiEntity", title: "Title", url: URL.init(string: "www.testWiki.com")!)
        entityArr.append(tmpEntity);
        let wiki = WikiChunk.init(entities: entityArr, length: 123, start: 32231, text: "Start of String")
        XCTAssertEqual(wiki.entities.count, entityArr.count)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
