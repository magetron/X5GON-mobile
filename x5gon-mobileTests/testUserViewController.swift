//
//  testUserViewController.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 29/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import XCTest
@testable import x5gon_mobile
class testUserViewController: XCTestCase {
    
    func makeUserViewController() -> UserViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let uvc = storyboard.instantiateViewController(identifier: "UserViewController") as! UserViewController
        uvc.loadViewIfNeeded()
        return uvc
    }
    
    var UserViewController:UserViewController?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserViewControllerTable() throws {
        let tv = UserViewController?.tableView
        XCTAssertNotNil(tv)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
