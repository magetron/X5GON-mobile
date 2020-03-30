//
//  testMainViewController.swift
//  x5gon-mobileUITests
//
//  Created by Patrick Wu on 30/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import XCTest

class testViewNavigation: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewNavigation() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let element4 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        let collectionViewsQuery = element4.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.tap()
        
        let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element
        element.tap()
        
        let element2 = collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element
        element2.tap()
        
        let appNavigationBar = app.navigationBars["App"]
        let navsettingsButton = appNavigationBar.buttons["navSettings"]
        navsettingsButton.tap()
        
        let loginStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".cells.staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        loginStaticText.tap()
        
        let element5 = element4.children(matching: .other).element(boundBy: 1)
        let button = element5.children(matching: .button).element
        button.tap()
        appNavigationBar.buttons["navSearch"].tap()
        app.buttons["cancel"].tap()
        element.tap()
        
        let collectionViewsQuery2 = app.collectionViews
        collectionViewsQuery2/*@START_MENU_TOKEN@*/.tables.staticTexts["History"]/*[[".cells.tables",".cells.staticTexts[\"History\"]",".staticTexts[\"History\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery2.buttons.staticTexts["Back"].tap()
        
        let logoutStaticText = collectionViewsQuery2/*@START_MENU_TOKEN@*/.tables.staticTexts["Logout"]/*[[".cells.tables",".cells.staticTexts[\"Logout\"]",".staticTexts[\"Logout\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        logoutStaticText.tap()
        navsettingsButton.tap()
        loginStaticText.tap()
        
        let element3 = element5.children(matching: .other).element
        element3.children(matching: .textField).element.tap()
        element3.children(matching: .secureTextField).element.tap()
        button.tap()
        logoutStaticText.tap()
        element2.tap()
        
    }
    
    func testHistoryAndBookMark () {
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.collectionViews.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.tap(); sleep(1)
        XCUIApplication().children(matching: .window).collectionViews.children(matching: .cell).tables.element(boundBy: 0).cells.element(boundBy: 0).tap(); sleep(10)
        XCUIApplication().buttons["Bookmark"].firstMatch.tap(); sleep(1)
        XCUIApplication().images["hand.thumbsup"].forceTapElement(); sleep(1)
        XCUIApplication().images["hand.thumbsup.fill"].forceTapElement(); sleep(1)
        XCUIApplication().images["hand.thumbsdown"].forceTapElement(); sleep(1)
        XCUIApplication().images["hand.thumbsdown.fill"].forceTapElement(); sleep(1)
        print(XCUIApplication().debugDescription)
        
        XCUIApplication().otherElements["Video"].swipeDown(); sleep(1)
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.collectionViews.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.tap(); sleep(1)
        
    }

}
