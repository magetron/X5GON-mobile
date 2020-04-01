//
//  ExtensionXCTest.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 29/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
@testable import x5gon_mobile

import XCTest
extension XCTestCase {
    func expectFatalError(expectedMessage: String, testcase: @escaping () -> Void) {
        // arrange
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String?

        // override fatalError. This will pause forever when fatalError is called.
        FatalErrorUtil.replaceFatalError { message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            unreachable()
        }

        // act, perform on separate thead because a call to fatalError pauses forever
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)

        waitForExpectations(timeout: 5) { _ in
            // assert
            XCTAssertEqual(assertionMessage, expectedMessage)

            // clean up
            FatalErrorUtil.restoreFatalError()
        }
    }
}
