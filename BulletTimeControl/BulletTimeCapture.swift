//
//  BulletTimeCapture.swift
//  BulletTimeControl
//
//  Created by Ben Rigas on 7/3/17.
//  Copyright © 2017 Rigas. All rights reserved.
//

import Cocoa

class BulletTimeCapture: NSObject {

    var images = [Int : NSImage]()
    let numberOfCameras: Int
    
    init(numberOfCameras: Int) {
        self.numberOfCameras = numberOfCameras
    }
    
    func addImageFromCamera(cameraNumber: Int, image: NSImage) {
        self.images[cameraNumber] = image
    }
    
    func allTheImagesInOrder() -> [NSImage] {
        var allTheImages = [NSImage]()
        
        for i in 0...numberOfCameras {
            allTheImages.append(images[i]!)
        }
        
        return allTheImages
    }
}
