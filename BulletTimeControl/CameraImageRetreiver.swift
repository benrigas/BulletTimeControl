//
//  CameraImageRetreiver.swift
//  BulletTimeControl
//
//  Created by Ben Rigas on 7/3/17.
//  Copyright © 2017 Rigas. All rights reserved.
//

import Cocoa

class CameraImageRetreiver: NSObject {

    let url: URL
    let cameraNumber: Int
    var delegate: CameraImageRetreiverDelegate?
    
    init(cameraNumber: Int, urlString: String) {
        self.url = URL(string: urlString)!
        self.cameraNumber = cameraNumber
    }
    
    func retreive(delay: Int) {
        
        let task = URLSession.shared.dataTask(with: self.url) { (data, response, error) in
            if let data = data, let image = NSImage(data: data) {
                self.delegate?.imageRetrieved(cameraNumber: self.cameraNumber, image: image)
            } else {
                print("Something went wrong, missed image from camera \(self.cameraNumber)")
            }
        }
        
        task.resume()
    }
}

protocol CameraImageRetreiverDelegate {
    func imageRetrieved(cameraNumber: Int, image: NSImage)
}
