//
//  testPlayerNavigationView.swift
//  x5gon-mobileTests
//
//  Created by Felix Hu on 30/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

@testable import x5gon_mobile
import XCTest
class testPlayerNavigationView: XCTestCase {
    func makeNavViewController() -> NavViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nvc = storyboard.instantiateInitialViewController() as! NavViewController
        nvc.loadView()
        return nvc
    }

    var nvc: NavViewController?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        nvc = makeNavViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNoteCell() {
        let content1 = Content(title: "1231", id: 23, channelName: "Test", description: "Nil", url: URL(string: "www.TEST.com")!)
        nvc?.playerView.content = content1
        let cell = nvc?.playerView.tableView((nvc?.playerView.tableView)!, cellForRowAt: IndexPath(row: 1, section: 0)) as? notesCell
        cell?.textViewDidEndEditing((cell?.textView)!)
        cell?.textViewDidBeginEditing((cell?.textView)!)
        let check = cell?.textView((cell?.textView)!, shouldChangeTextIn: NSRange(location: 0, length: 0), replacementText: "1232")
        cell?.prepareForReuse()
        XCTAssertNotNil(check)
    }

    func testNoteCellCaseTwo() {
        let content1 = Content(title: "1231", id: 23, channelName: "Test", description: "Nil", url: URL(string: "www.TEST.com")!)
        nvc?.playerView.content = content1
        let cell = nvc?.playerView.tableView((nvc?.playerView.tableView)!, cellForRowAt: IndexPath(row: 1, section: 0)) as? notesCell
        let check = cell?.textView((cell?.textView)!, shouldChangeTextIn: NSRange(location: 0, length: 0), replacementText: "\n")
        XCTAssertNotNil(check)
    }

    func testPlayerNavigationView() {
        nvc?.playerView.navigationView.hideNavigationView("true")
        var entityArr = [WikiEntity]()
        var wikiChunkArr = [WikiChunk]()
        let tmpEntity = WikiEntity(id: "Test WikiEntity", title: "Title", url: URL(string: "www.testWiki.com")!)
        entityArr.append(tmpEntity)
        let wikiChunk = WikiChunk(entities: entityArr, length: 123, start: 32231, text: "Start of String")
        wikiChunkArr.append(wikiChunk)
        let wiki = Wiki(chunks: wikiChunkArr)
        nvc?.playerView.navigationView.setWiki(wiki: wiki)
        let cell = nvc?.playerView.navigationView.tableView((nvc?.playerView.navigationView.tableView)!, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
