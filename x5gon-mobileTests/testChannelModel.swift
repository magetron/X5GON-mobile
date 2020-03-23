//
//  testChannelModel.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 23/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import XCTest
@testable import x5gon_mobile
class testChannelModel: XCTestCase {
    var channelSet = [Channel]()
    let channel = Channel.init(name: "Test Channel", image: UIImage.init(named: "banner")!)
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testChannelSet(){
        let num = channelSet.count
        XCTAssertEqual(num, 0)
    }
    
    func testChannelName(){
        let name = channel.name
        XCTAssertEqual(name, "Test Channel")
    }
    
    func testChannelImage(){
        let image = channel.image
        let testImage = UIImage.init(named: "pl-node")
        XCTAssertNotEqual(image, testImage)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
