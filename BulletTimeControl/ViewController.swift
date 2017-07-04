//
//  ViewController.swift
//  BulletTimeControl
//
//  Created by Ben Rigas on 7/3/17.
//  Copyright © 2017 Rigas. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!
    
    var imageRetreivers = [CameraImageRetreiver]()
    var bulletTimeCapture: BulletTimeCapture?
    var timer: Timer?
    var lastImageIndex = 0
    let numberOfCameras = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRetrievers()
        //setupDisplayTimer()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func setupDisplayTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
    }
    
    func timerTick() {
        var nextImageIndex = self.lastImageIndex
        
        if (nextImageIndex == self.numberOfCameras) {
            nextImageIndex = 0
            lastImageIndex = 0
        }
        
        DispatchQueue.main.async {
            self.imageView.image = self.bulletTimeCapture?.images[nextImageIndex]
            self.lastImageIndex += 1
        }
    }
    
    func setupRetrievers() {
        for i in 0...self.numberOfCameras - 1 {
            let imageRetriever = CameraImageRetreiver(cameraNumber: i, urlString: "http://picam\(i).local:5000/takePhotoNow?delay=0")
            imageRetreivers.append(imageRetriever)
        }
    }

    @IBAction func takePhotoTapped(_ sender: Any) {
        self.bulletTimeCapture = BulletTimeCapture(numberOfCameras: self.numberOfCameras)
        
        for imageRetriever in imageRetreivers {
            imageRetriever.retreive(delay: 0) { (image) in
                if let image = image {
                    DispatchQueue.main.sync {
                        self.bulletTimeCapture?.addImageFromCamera(cameraNumber: imageRetriever.cameraNumber, image: image)
                    }
                }
            }
        }
    }

}

