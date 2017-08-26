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
        let images = [NSImage(named: "1.jpeg")!, NSImage(named: "2.jpeg")!, NSImage(named: "3.jpeg")!, NSImage(named: "4.jpeg")!]
        let result = GIFWriter.exportAnimatedGif(toFilePath: URL(fileURLWithPath: "/tmp/foo.gif") as NSURL, withImages: images)
        
        XCTAssertTrue(result)
    }
    
    func test24() {
        let images = [
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/1/out0.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/2/out0.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/3/out0.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/4/out0.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/5/out0.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/6/out0.jpg")!,

            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/1/out1.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/2/out1.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/3/out1.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/4/out1.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/5/out1.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/6/out1.jpg")!,
            
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/1/out2.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/2/out2.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/3/out2.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/4/out2.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/5/out2.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/6/out2.jpg")!,
            
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/1/out3.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/2/out3.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/3/out3.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/4/out3.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/5/out3.jpg")!,
            NSImage (contentsOfFile: "/Users/benrigas/Documents/APPS/bt-test-caps/6/out3.jpg")!
        ]
        
        let result = GIFWriter.exportAnimatedGif(toFilePath: URL(fileURLWithPath: "/tmp/foo24.gif") as NSURL, withImages: images)
        XCTAssertTrue(result)
        
    }

}
