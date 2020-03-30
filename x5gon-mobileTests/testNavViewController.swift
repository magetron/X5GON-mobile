//
//  testNavViewController.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 30/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import XCTest
@testable import x5gon_mobile
class testNavViewController: XCTestCase {
    
    func makeNavViewController() -> NavViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nvc = storyboard.instantiateInitialViewController() as! NavViewController
        nvc.loadView()
        return nvc
     }
    
    var nvc:NavViewController?

    override func setUpWithError() throws {
        nvc = makeNavViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShowSearchView() {
        XCTAssertNotNil(nvc?.playerView)
        XCTAssertNotNil(nvc?.searchView)
        XCTAssertNotNil(nvc?.playerView.tableView)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
