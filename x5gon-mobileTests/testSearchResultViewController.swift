//
//  testSearchResultViewController.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 30/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import XCTest
@testable import x5gon_mobile
class testSearchResultViewController: XCTestCase {

   func makeSearchResultsViewController() -> SearchResultsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let srvc = storyboard.instantiateViewController(identifier: "SearchResultsViewController") as! SearchResultsViewController
        srvc.loadViewIfNeeded()
        return srvc
    }
    
    var searchResultsViewController:SearchResultsViewController?

    override func setUp() {
        searchResultsViewController = makeSearchResultsViewController()
        let content1 = Content.init(title: "1231", id: 0, channelName: "Test", description: "Nil", url: URL.init(string: "www.TEST.com")!)
        searchResultsViewController?.contents.append(content1)
    }
    
    func testSearchViewControllerTable() {
        let tv = searchResultsViewController?.tableView
        XCTAssertNotNil(tv)
        
    }
    
    func testTableViewContent(){
        let num = searchResultsViewController?.tableView(searchResultsViewController!.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(1, num)
    }
    
    func testTableViewCount(){
        let cell  = searchResultsViewController?.tableView(searchResultsViewController!.tableView, cellForRowAt: IndexPath(row: 0, section: 0))as? ContentCell
        XCTAssertNotNil(cell)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
