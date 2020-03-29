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
    
    var userViewController:UserViewController?

    override func setUpWithError() throws {
        userViewController = makeUserViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserViewControllerTable() {
        let tv = userViewController?.tableView
        XCTAssertNotNil(tv)
        
    }
    
    func testUserViewControllerTalbleViewHasDelegates(){
        let delegate = userViewController?.tableView.delegate
        XCTAssertNotNil(delegate)
    }
    
    func testUserHeaderCell(){
        let cell = userViewController?.tableView(userViewController!.tableView, cellForRowAt: IndexPath(row: 0, section: 0))as? userHeaderCell
        XCTAssertNotNil(cell)
    }
    
    func testUserMenuCell(){
        let cell = userViewController?.tableView(userViewController!.tableView, cellForRowAt: IndexPath(row: 1, section: 0))as? userMenuCell
        XCTAssertNotNil(cell)
    }
    
    func testUserPlayListCell(){
        let cell = userViewController?.tableView(userViewController!.tableView, cellForRowAt: IndexPath(row: 0, section: 1))as? userPlaylistCell
        XCTAssertNil(cell)
        
    }
    
    
    func testDidSelect(){
        let check: ()? = userViewController?.tableView(userViewController!.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(check)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
