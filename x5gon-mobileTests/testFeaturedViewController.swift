//
//  testFeaturedViewController.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 29/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

@testable import x5gon_mobile
import XCTest
class testFeaturedViewController: XCTestCase {
    func makeFeaturedViewController() -> FeaturedViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let fvc = storyboard.instantiateViewController(identifier: "FeaturedViewController") as! FeaturedViewController
        fvc.loadViewIfNeeded()
        return fvc
    }

    var featuredViewController: FeaturedViewController?

    override func setUpWithError() throws {
        featuredViewController = makeFeaturedViewController()
        let content1 = Content(title: "1231", id: 0, channelName: "Test", description: "Nil", url: URL(string: "www.TEST.com")!)
        featuredViewController?.contents.append(content1)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserViewControllerTable() throws {
        let tv = featuredViewController?.tableView
        XCTAssertNotNil(tv)
    }

    func testTableViewCount() {
        let cell = featuredViewController?.tableView(featuredViewController!.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ContentCell
        XCTAssertNotNil(cell)
    }

    func testRefresh() {
        let check: ()? = featuredViewController?.refresh(sender: "refresh")
        XCTAssertNotNil(check)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
