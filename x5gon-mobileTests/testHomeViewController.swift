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
        let content1 = Content.init(title: "1231", id: 0, channelName: "Test", description: "Nil", url: URL.init(string: "www.TEST.com")!)
        homeViewController?.contents.append(content1)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTableView() {
        let tv = homeViewController?.tableView
        XCTAssertNotNil(tv)
    }
    
    func testTableViewCount(){
        let cell  = homeViewController?.tableView(homeViewController!.tableView, cellForRowAt: IndexPath(row: 0, section: 0))as? ContentCell
        XCTAssertNotNil(cell)
    }
    
    func testRefresh(){
        let check: ()? = homeViewController?.refresh(sender: "refresh")
        XCTAssertNotNil(check)
    }
    
    func testReportContent(){
        let cell  = homeViewController?.tableView(homeViewController!.tableView, cellForRowAt: IndexPath(row: 0, section: 0))as? ContentCell
        let check: ()? = cell?.reportContent()
        XCTAssertNotNil(check)
    }
    
    func testReuseFunc(){
        let cell  = homeViewController?.tableView(homeViewController!.tableView, cellForRowAt: IndexPath(row: 0, section: 0))as? ContentCell
        let check:()? = cell?.prepareForReuse()
        XCTAssertNotNil(check)
    }
    
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
