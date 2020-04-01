//
//  testNavigationViewController.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 29/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

@testable import x5gon_mobile
import XCTest
class testNavigationViewController: XCTestCase {
    func makeNaviViewController() -> NavViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nvc = storyboard.instantiateViewController(identifier: "App") as! NavViewController
        nvc.loadViewIfNeeded()
        return nvc
    }

    var navViewController: NavViewController?

    override func setUpWithError() throws {
        navViewController = makeNaviViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShowLogin() {
        let check: ()? = navViewController?.showLogin()
        XCTAssertNotNil(check)
    }

    func testShowSetting() {
        let check: ()? = navViewController?.showSettings()
        XCTAssertNotNil(check)
    }

    func testShowSearch() {
        let check: ()? = navViewController?.showSearch()
        XCTAssertNotNil(check)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
