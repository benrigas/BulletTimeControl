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
    var timer: Timer?
    var currentCount = 0
    
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
        if let shareURL = currentCaptureDirectory?.appendingPathComponent("capture.mp4") {
            let sharing = NSSharingServicePicker(items: [shareURL])
            sharing.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.minY)
        }
    }
    
    @IBAction func boopTapped(_ sender: Any) {
        guard let button = sender as? NSButton else { return }
        
        button.isEnabled = false
        self.imageView.image = nil
        ScriptUtil.runResetCurrentCaptureScript()

        startCountdownTimer(waitTime: 6) {
            
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            MulticastSender.sendBroadcast()
            button.isEnabled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.bulletTimeCaptureReady(capture: BulletTimeCapture(numberOfCameras: 24), captureDirectory: URL(fileURLWithPath: "/Users/benrigas/Documents/BulletTime/current"))
            }
        }
    }
    
    func startCountdownTimer(waitTime: Int, completion: @escaping () -> Void) {
        currentCount = waitTime
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            print("Current = \(self.currentCount)")
            if self.currentCount == 1 {
                timer.invalidate()
//                ScriptUtil.runSayScript(message: "Beep!")
                NSSound(named: NSSound.Name("Glass"))?.play()
                completion()
            } else {
                self.currentCount = self.currentCount - 1
                ScriptUtil.runSayScript(message: "\(self.currentCount)")
            }
        })
    }
    
    @IBAction func takePhotoTapped(_ sender: Any) {
        currentCapture = nil
        imageView.image = nil
        imageCollector.delegate = self
        imageCollector.getPhotosFromAllTheCameras()
    }
    
    // called after all the image collectors finish
    func bulletTimeCaptureReady(capture: BulletTimeCapture, captureDirectory: URL) {
        currentCapture = capture
        currentCaptureDirectory = captureDirectory
        
        ScriptUtil.runApplyOffsetsScript(path: captureDirectory.path)
        
        let gifURL = captureDirectory.appendingPathComponent("capture.gif") as NSURL

        //let result = GIFWriter.exportAnimatedGif(toFilePath: gifURL, withImages: capture.allTheImagesInOrder())
        ScriptUtil.runMakeGifScript(path: captureDirectory.path)
//        print("Wrote gif with result \(result)")
        DispatchQueue.main.async {
            self.imageView.image = NSImage(contentsOfFile: gifURL.path!)
            self.imageView.animates = true
        }
        
        ScriptUtil.runMovieMakerScript(path: captureDirectory.path)
    }
    
//    func runResetCurrentCaptureScript() {
//        if let path = currentCaptureDirectory?.path {
//            let task = Process()
//            task.launchPath = "/Users/benrigas/BulletTimeControl/resetCurrentCapture.sh"
//            task.arguments = [path]
//            task.launch()
//            task.waitUntilExit()
//        }
//    }
//
//    func runApplyOffsetsScript() {
//        if let path = currentCaptureDirectory?.path {
//            let task = Process()
//            task.launchPath = "/Users/benrigas/BulletTimeControl/apply-offsets.py"
//            task.arguments = [path]
//            task.launch()
//            task.waitUntilExit()
//        }
//    }
//
//    func runMakeGifScript() {
//        if let path = currentCaptureDirectory?.path {
//            let task = Process()
//            task.launchPath = "/Users/benrigas/BulletTimeControl/create-gif.sh"
//            task.arguments = [path]
//            task.launch()
//            task.waitUntilExit()
//        }
//    }
//
//    func runMovieMakerScript() {
//        if let path = currentCaptureDirectory?.path {
//            let task = Process()
//            task.launchPath = "/Users/benrigas/BulletTimeControl/gif2movie.sh"
//            task.arguments = [path]
//            task.launch()
//            task.waitUntilExit()
//        }
//    }
//
    @IBAction func doTheCalibrationMagic(_ sender: Any) {
        calibrator.calibrateWithMulticast()
    }
}

