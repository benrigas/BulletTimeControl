//
//  CameraCalibrator.swift
//  BulletTimeControl
//
//  Created by Ben Rigas on 11/4/18.
//  Copyright © 2018 Rigas. All rights reserved.
//

import Cocoa

class CameraCalibrator: NSObject {
    
    let imageCollector = CameraImageRetrieverCollection()
}

extension CameraCalibrator: CameraImageRetrieverCollectionDelegate {
    func bulletTimeCaptureReady(capture: BulletTimeCapture, captureDirectory: URL) {
        let path = captureDirectory.path
        let task = Process()
        task.launchPath = "/Users/benrigas/BulletTimeControl/calculate_offsets.py"
        task.arguments = [path]
        if #available(OSX 10.13, *) {
            do {
                try task.run()
                task.waitUntilExit()
                print("output=\(task.standardOutput ?? "ruh roh")")
            } catch {
                print("boo.. \(task.terminationReason)")
            }
        } else {
            // Fallback on earlier versions
        }
//        task.launch()
//        task.waitUntilExit()
//        print("output=\(task.standardOutput ?? "ruh roh")")
    }
    
    func calibrate() {
        imageCollector.delegate = self
        imageCollector.getPhotosFromAllTheCameras()
    }
}
