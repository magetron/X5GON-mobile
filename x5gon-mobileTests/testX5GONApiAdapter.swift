//
//  testX5GONApiAdapter.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 24/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import XCTest
@testable import x5gon_mobile
class testX5GONApiAdapter: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRootUrl(){
        let url = X5GONAPIAdapter.rootURL()
        XCTAssertEqual(url, "https://platform.x5gon.org/")
    }
    
    func testAPIVersion(){
        let url = X5GONAPIAdapter.APIVersion()
        XCTAssertEqual(url, "api/v1/")
    }
    
    func testGenerateContentQueryURL(){
        let url = X5GONAPIAdapter.generateContentQueryURL(keyWord: "abc", contentType: "pdf")
        XCTAssertEqual(url, X5GONAPIAdapter.rootURL() + X5GONAPIAdapter.APIVersion() + "recommend/oer_materials?text=" + "abc" + "&types=" + "pdf")
    }
    func testGenerateUserSessionQueryURL(){
        expectFatalError(expectedMessage: "error: X5GON does not provide a user-session URL") {
            X5GONAPIAdapter.generateUserSessionQueryURL()
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
