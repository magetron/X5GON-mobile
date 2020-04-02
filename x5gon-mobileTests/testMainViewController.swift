//
//  testMainViewController.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 30/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

@testable import x5gon_mobile
import XCTest
class testMainViewController: XCTestCase {
    let mvc = MainViewController()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHide() {
        let check: () = mvc.hideBar(notification: NSNotification(name: NSNotification.Name("hide"), object: true))
        XCTAssertNotNil(check)
    }

    func testScrollViews() {
        let check: () = mvc.scrollViews(notification: NSNotification(name: NSNotification.Name("didSelectMenu"), object: "Home: 0") as Notification)

        XCTAssertNotNil(check)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
