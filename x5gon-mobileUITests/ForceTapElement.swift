////
////  ForceTapElement.swift
////  x5gon-mobileUITests
////
////  Created by Patrick Wu on 28/03/2020.
////  Copyright © 2020 x5gon. All rights reserved.
////

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
