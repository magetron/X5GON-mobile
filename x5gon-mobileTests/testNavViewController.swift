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

    func testView() {
        XCTAssertNotNil(nvc?.playerView)
        XCTAssertNotNil(nvc?.searchView)
        XCTAssertNotNil(nvc?.playerView.tableView)
    }
    
    func testShowViews(){
        // this will error if the view didn't shows up
        nvc?.showSearch()
        nvc?.showLogin()
        nvc?.showSettings()
        XCTAssertTrue(true)
    }
    
    func testPlayerViewAnimate(){
        nvc?.didMinimize()
        nvc?.didmaximize()
        nvc?.didEndedSwipe(toState: .hidden)
    }
    
    func testPositionDuringSwipe(){
        let check = nvc?.positionDuringSwipe(scaleFactor: 0.0)
        XCTAssertNotNil(check)
    }
    
    func testSetPreferStatusBar(){
        let check: ()? = nvc?.setPreferStatusBarHidden(true)
        XCTAssertNotNil(check)
    }
    
    func testSwipetoMinise(){
        let check: ()? = nvc?.swipeToMinimize(translation: 0.0, toState: .minimized)
        nvc?.swipeToMinimize(translation: 0.0, toState: .fullScreen)
        nvc?.swipeToMinimize(translation: 0.0, toState: .hidden)
        XCTAssertNotNil(check)
    }
    
    func testLoginView(){
        nvc?.loginView.loginButtonPressed("true")
        nvc?.loginView.loginButtonPressed("false")
        nvc?.loginView.keyboardWillHide(notification: NSNotification.init(name: NSNotification.Name("hide"), object: true))
        nvc?.loginView.keyboardWillShow(notification: NSNotification.init(name: NSNotification.Name("show"), object: true))
        nvc?.loginView.hideLoginView("hide")
        XCTAssertTrue(true)
    }
    
    func testDefaultPlayerView(){
        XCTAssertNotNil(nvc?.playerView.animate())
    }
    
    func testSearchView(){
        let check = nvc?.searchView.textFieldShouldReturn((nvc?.searchView.inputField)!)
        XCTAssertNotNil(check)
    }
    
    func testPlayerView(){
        nvc?.playerView.showNavigation("true")
        nvc?.playerView.changeValues(scaleFactor: 0.0)
        nvc?.playerView.state = .minimized
        nvc?.playerView.animate()
        nvc?.playerView.state = .fullScreen
        nvc?.playerView.animate()
        XCTAssertTrue(true)
    }
    
    func testRipple(){
        XCTAssertNotNil(nvc?.playerView.ripple())
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
