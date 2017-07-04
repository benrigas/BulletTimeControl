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
    
    init(cameraNumber: Int, urlString: String) {
        self.url = URL(string: urlString)!
        self.cameraNumber = cameraNumber
    }
    
    func retreive(delay: Int, completion: @escaping (_ image: NSImage?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: self.url) { (data, response, error) in
            var image: NSImage?
            if let data = data {
                image = NSImage(data: data)
            }
            completion(image)
        }
        
        task.resume()
    }
    
}
