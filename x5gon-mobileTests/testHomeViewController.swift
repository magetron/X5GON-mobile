//
//  testHomeViewController.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 29/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import XCTest

@testable import x5gon_mobile

class testHomeViewController: XCTestCase {
        
    func makeHomeViewController() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let hvc = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        hvc.loadViewIfNeeded()
        return hvc
    }
    
    var homeViewController:HomeViewController?

    override func setUp() {
        homeViewController = makeHomeViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTableView() {
        let tv = homeViewController?.tableView
        XCTAssertNotNil(tv)
    }
    
    func testTableViewCount(){
        let cell  = homeViewController?.tableView
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

