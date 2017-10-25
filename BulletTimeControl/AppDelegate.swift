//
//  AppDelegate.swift
//  BulletTimeControl
//
//  Created by Ben Rigas on 7/3/17.
//  Copyright © 2017 Rigas. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
//        URLCache.setSharedCache(URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil))
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

