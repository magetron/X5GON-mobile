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
        let generateUser = User.init(name: "Felix Hu", profilePic: UIImage.init(named: "profilePic")!, backgroundImage: UIImage.init(named: "banner")!)
        let content1 = Content.init(title: "1231", id: 0, channelName: "Test", description: "Nil", url: URL.init(string: "www.TEST.com")!)
        userViewController?.setUser(user: generateUser)
        userViewController?.user.bookmarkedContent.insert(content1)
        let cell = userViewController?.tableView(userViewController!.tableView, cellForRowAt: IndexPath(row: 6, section: 0))as? userPlaylistCell
        XCTAssertNotNil(cell)
        
    }
    
    
    func testDidSelect(){
        let check: ()? = userViewController?.tableView(userViewController!.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(check)
    }
    
    func testUserHitoryView(){
        let check: ()? = userViewController?.showHistory()
        XCTAssertNotNil(check)
    }
    
    func testSetUser(){
        let generateUser = User.init(name: "Felix Hu", profilePic: UIImage.init(named: "profilePic")!, backgroundImage: UIImage.init(named: "profilePic")!)
        userViewController?.setUser(user: generateUser)
        let name = userViewController?.user.name
        XCTAssertEqual(name, "Felix Hu")
        
    }
    
    func testUserHistoryViewCycle(){
        let hsv = userViewController?.historyView
        hsv?.awakeFromNib()
        XCTAssertNotNil(hsv)
        
    }
    
    func testUserHistoryViewTable(){
        let hsv = userViewController?.historyView
        let tv = hsv?.tableView
        XCTAssertNotNil(tv)
        
    }
    
    func testUserHistoryViewCell(){
        let content1 = Content.init(title: "1231", id: 0, channelName: "Test", description: "Nil", url: URL.init(string: "www.TEST.com")!)
        let hsv = userViewController?.historyView
        hsv?.historyContent.append(content1)
        let cell  = hsv?.tableView((hsv?.tableView)!, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
    }
    
    func testUserHistoryViewHide(){
        let check: ()? = userViewController?.historyView.hideHistoryView("hide")
        XCTAssertNotNil(check)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
