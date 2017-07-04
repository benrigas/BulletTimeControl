//
//  GIFWriter.swift
//  BulletTimeControl
//
//  Created by Ben Rigas on 7/4/17.
//  Copyright © 2017 Rigas. All rights reserved.
//

import Cocoa

struct ImageConstants {
    static let gifDelayTime: NSNumber = 0.3
    static let gifLoopCount:NSNumber = 10
}

class GIFWriter: NSObject {
    
    //swift 2.0 translation/adaptation from https://gist.github.com/akisute/1141953
    //NSImage extension to export an array of NSImages to an animated gif at a given location
    static func exportAnimatedGif(toFilePath filePath: NSURL, withImages images: [NSImage]) -> Bool {
        guard let fileDestination: CGImageDestination = CGImageDestinationCreateWithURL((filePath as CFURL), kUTTypeGIF, images.count, nil) else {
            return false
        }
        
        let frameProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String: ImageConstants.gifDelayTime]]
        let gifProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: ImageConstants.gifLoopCount]]
        
        for (_, image) in images.enumerated() {
            let imageRef: CGImage =  NSImage.makeCGImage(image: image)
            CGImageDestinationAddImage(fileDestination, imageRef, (frameProperties as CFDictionary))
        }
        
        CGImageDestinationSetProperties(fileDestination, (gifProperties as CFDictionary))
        CGImageDestinationFinalize(fileDestination)
        return true
    }
    
    static func makeCGImage(image: NSImage)->CGImage {
        var imageRect:CGRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        return image.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)!
    }

}

extension NSImage {
    static func makeCGImage(image: NSImage)->CGImage {
        var imageRect:CGRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        return image.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)!
    }
}
