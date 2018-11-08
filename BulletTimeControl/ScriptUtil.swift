//
//  ScriptUtil.swift
//  BulletTimeControl
//
//  Created by Ben Rigas on 11/8/18.
//  Copyright © 2018 Rigas. All rights reserved.
//

import Cocoa

class ScriptUtil: NSObject {
    
    class func runSayScript(message: String) {
        let task = Process()
        task.launchPath = "/usr/bin/say"
        task.arguments = [message]
        task.launch()
        //task.waitUntilExit()
    }
    
    class func runResetCurrentCaptureScript() {
        let task = Process()
        task.launchPath = "/Users/benrigas/BulletTimeControl/resetCurrentCapture.sh"
        task.arguments = []
        task.launch()
        task.waitUntilExit()
    }
    
    class func runApplyOffsetsScript(path: String) {
        let task = Process()
        task.launchPath = "/Users/benrigas/BulletTimeControl/apply-offsets.py"
        task.arguments = [path]
        task.launch()
        task.waitUntilExit()
    }
    
    class func runMakeGifScript(path: String) {
        let task = Process()
        task.launchPath = "/Users/benrigas/BulletTimeControl/create-gif.sh"
        task.arguments = [path]
        task.launch()
        task.waitUntilExit()
    }
    
    class func runMovieMakerScript(path: String) {
        let task = Process()
        task.launchPath = "/Users/benrigas/BulletTimeControl/gif2movie.sh"
        task.arguments = [path]
        task.launch()
        task.waitUntilExit()
    }
    
    
}
