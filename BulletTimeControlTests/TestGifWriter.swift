//
//  TestGifWriter.swift
//  BulletTimeControl
//
//  Created by Ben Rigas on 7/4/17.
//  Copyright © 2017 Rigas. All rights reserved.
//

import XCTest

class TestGifWriter: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGifMaker() {
        let gw = GIFWriter()
        
        let images = [NSImage(named: "1.jpeg")!, NSImage(named: "2.jpeg")!, NSImage(named: "3.jpeg")!, NSImage(named: "4.jpeg")!]
        
        let result = gw.exportAnimatedGif(toFilePath: URL(fileURLWithPath: "/tmp/foo.gif") as NSURL, withImages: images)
        
        XCTAssertTrue(result)
    }

}
