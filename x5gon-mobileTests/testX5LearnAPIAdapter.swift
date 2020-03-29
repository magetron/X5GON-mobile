//
//  testX5LearnAPIAdapter.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 24/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import XCTest
@testable import x5gon_mobile
class testX5LearnAPIAdapter: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRootUrl(){
        let url = X5LearnAPIAdapter.rootURL()
        XCTAssertEqual(url, "http://x5learn.org/")
    }
    
    func testAPIVersion(){
        let url = X5LearnAPIAdapter.APIVersion()
        XCTAssertEqual(url, "api/v1/")
    }
    
    func testGenerateContentQueryURL(){
        let url = X5LearnAPIAdapter.generateContentQueryURL(keyWord: "act", contentType: "audio")
        XCTAssertEqual(url, "http://x5learn.org/" + "api/v1/" + "search/?text=" + "act" )
    }
    
    func testGenerateLoginQueryURL(){
        let url = X5LearnAPIAdapter.generateLoginQueryURL()
        XCTAssertEqual(url, "http://x5learn.org/" + "login")
    }
    
    func testGenerateLogOutQueryURL(){
        let url = X5LearnAPIAdapter.gererateLogoutQueryURL()
        XCTAssertEqual(url, "http://x5learn.org/" + "logout")
    }
    
    func testGenerateSessionQueryURL(){
        let url = X5LearnAPIAdapter.generateUserSessionQueryURL()
        XCTAssertEqual(url, "http://x5learn.org/" + "api/v1/" + "session")
    }
    
    func testGenerateFeaturedQueryURL(){
        let url = X5LearnAPIAdapter.generateFeaturedContentURL()
        XCTAssertEqual(url, "http://x5learn.org/" + "api/v1/" + "featured")
    }
    
    func testGenerateWikiChunkEnrichmentsURL(){
        let url = X5LearnAPIAdapter.generateWikiChunkEnrichmentsURL()
        XCTAssertEqual(url, "http://x5learn.org/" + "api/v1/" + "wikichunk_enrichments")
    }
    
    func testGenerateNotesURLOne(){
        let url = X5LearnAPIAdapter.generateNotesURL()
        XCTAssertEqual(url, "http://x5learn.org/" + "api/v1/" + "note")
    }
    
    func testGenerateNotesURLTwo(){
        let url = X5LearnAPIAdapter.generateNotesURL(id: 123)
        XCTAssertEqual(url, "http://x5learn.org/" + "api/v1/" + "note/\(123)")
    }
    
    func testTBD_generateBookmarkURL(){
        let url = X5LearnAPIAdapter.TBD_generateBookmarkURL(id: 123, bookmark: true)
        XCTAssertEqual(url, "http://x5learn.org/" + "api/v1/" + "bookmark/\(123)")
    }
    
    func testTBD_generateReportURL(){
        let url = X5LearnAPIAdapter.TBD_generateReportURL(id: 123)
        XCTAssertEqual(url, "http://x5learn.org/" + "api/v1/" + "report/\(123)")
    }
    
    



    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
