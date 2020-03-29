//
//  testHomeViewController.swift
//  x5gon-mobileUITests
//
//  Created by Felix Hu on 28/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import XCTest
@testable import x5gon_mobile
class testHomeViewController: XCTestCase {

    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHomeViewController(){
        
        let app = XCUIApplication()
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let collectionViewsQuery = element2.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.tap()
        
        let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element
        element.tap()
        element.swipeRight()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
        let appNavigationBar = app.navigationBars["App"]
        appNavigationBar.buttons["navSettings"].tap()
        element2.children(matching: .other).element(boundBy: 1).children(matching: .button).element.tap()
        appNavigationBar.buttons["navSearch"].tap()
        app.buttons["cancel"].tap()
        appNavigationBar.staticTexts["Home"].tap()
                
    }


}
