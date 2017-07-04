//
//  ViewController.swift
//  BulletTimeControl
//
//  Created by Ben Rigas on 7/3/17.
//  Copyright © 2017 Rigas. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, CameraImageRetrieverCollectionDelegate {



    @IBOutlet weak var imageView: NSImageView!
    let imageCollector = CameraImageRetrieverCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = NSImage(contentsOfFile: "/tmp/foo.gif")
        imageView.animates = true
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func shareButtonTapped(_ sender: NSButton) {
        let sharing = NSSharingServicePicker(items: [NSURL(fileURLWithPath: "/tmp/capture.gif")])
        sharing.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.minY)
    }
    
    @IBAction func takePhotoTapped(_ sender: Any) {
        imageCollector.delegate = self
        imageCollector.getPhotosFromAllTheCameras()
    }
    
    func bulletTimeCaptureReady(capture: BulletTimeCapture) {
        let result = GIFWriter.exportAnimatedGif(toFilePath: NSURL(fileURLWithPath: "/tmp/capture.gif"), withImages: capture.allTheImagesInOrder())
        
        print("Wrote gif with result \(result)")
        
        DispatchQueue.main.async {
            self.imageView.image = NSImage(contentsOfFile: "/tmp/capture.gif")
            self.imageView.animates = true
        }
    }

}

