//
//  testAPI.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 24/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

@testable import x5gon_mobile
import XCTest
class testAPI: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchCSRFToken() {
        let result = API.fetchCSRFToken()
        XCTAssertNotNil(result)
    }

    func testLogOut() {
        API.logout()
        XCTAssertTrue(true)
    }

    func testDEPRECATED_fetchContents() {
        let result = API.DEPRECATED_fetchContents(keyWord: "science")
        MainController.Queue.cancelOperations()
        XCTAssertNotNil(result)
    }

    func testDEPRECATED_fetchContentsWithContenType() {
        let result = API.DEPRECATED_fetchContents(keyWord: "sciecn", contentType: "pdf")
        MainController.Queue.cancelOperations()
        XCTAssertNotNil(result)
    }

    func testTBD_Report() {
        let check: () = API.TBD_report(id: 120, reason: "I just want to report it!")
        XCTAssertNotNil(check)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
