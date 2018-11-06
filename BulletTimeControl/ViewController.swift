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
    var currentCapture: BulletTimeCapture?
    var currentCaptureDirectory: URL?
    var calibrator = CameraCalibrator()
    
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
    
    @IBAction func settingsTapped(_ sender: Any) {
        
    }
    
    @IBAction func shareButtonTapped(_ sender: NSButton) {
        let sharing = NSSharingServicePicker(items: [NSURL(fileURLWithPath: "/tmp/capture.gif")])
        sharing.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.minY)
    }
    
    @IBAction func takePhotoTapped(_ sender: Any) {
        currentCapture = nil
        imageCollector.delegate = self
        imageCollector.getPhotosFromAllTheCameras()
    }
    
    // called after all the image collectors finish
    func bulletTimeCaptureReady(capture: BulletTimeCapture, captureDirectory: URL) {
        currentCapture = capture
        currentCaptureDirectory = captureDirectory
        
        runApplyOffsetsScript()
        
        let gifURL = captureDirectory.appendingPathComponent("capture.gif") as NSURL

        let result = GIFWriter.exportAnimatedGif(toFilePath: gifURL, withImages: capture.allTheImagesInOrder())
        
        print("Wrote gif with result \(result)")
        
        runMovieMakerScript()
        
        DispatchQueue.main.async {
            self.imageView.image = NSImage(contentsOfFile: gifURL.path!)
            self.imageView.animates = true
        }
    }
    
    func runApplyOffsetsScript() {
        if let path = currentCaptureDirectory?.path {
            let task = Process()
            task.launchPath = "/Users/benrigas/BulletTimeControl/apply-offsets.py"
            task.arguments = [path]
            task.launch()
            task.waitUntilExit()
        }
    }
    
    func runMovieMakerScript() {
        if let path = currentCaptureDirectory?.path {
            let task = Process()
            task.launchPath = "/Users/benrigas/BulletTimeControl/gif2movie.sh"
            task.arguments = [path]
            task.launch()
            task.waitUntilExit()
        }
    }
    
    @IBAction func doTheCalibrationMagic(_ sender: Any) {
        calibrator.calibrate()
    }
}

