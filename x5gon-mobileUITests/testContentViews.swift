//
//  testHomeViewController.swift
//  x5gon-mobileUITests
//
//  Created by Felix Hu on 28/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import XCTest

extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
        }
    }
}

class testContentViews: XCTestCase {

    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testContentViews(){
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.collectionViews.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.tap()
        sleep(1)
        XCUIApplication().staticTexts["Deep learning in the brain"].forceTapElement()

    }


}
