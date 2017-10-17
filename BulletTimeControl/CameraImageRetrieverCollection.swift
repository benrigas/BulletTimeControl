//
//  CameraImageRetrieverCollection.swift
//  BulletTimeControl
//
//  Created by Ben Rigas on 7/4/17.
//  Copyright © 2017 Rigas. All rights reserved.
//

import Cocoa

class CameraImageRetrieverCollection: NSObject, CameraImageRetreiverDelegate {
    
    let numberOfCameras = 24
    var delegate: CameraImageRetrieverCollectionDelegate?
    var imageRetrievers = [CameraImageRetreiver]()
    var bulletTimeCapture: BulletTimeCapture?
    let syncQueue = DispatchQueue(label: "imageCollectionSync")
    
    override init() {
        super.init()
        setupRetrievers()
    }
    
    func setupRetrievers() {
        for i in 1...self.numberOfCameras {
            let imageRetriever = CameraImageRetreiver(cameraNumber: i, urlString: "http://picam\(i).local:5000/takePhotoNow?delay=0")
            imageRetrievers.append(imageRetriever)
        }
    }
    
    func getPhotosFromAllTheCameras() {
        bulletTimeCapture = BulletTimeCapture(numberOfCameras: self.imageRetrievers.count)
        for imageRetriever in imageRetrievers {
            imageRetriever.delegate = self
            imageRetriever.retreive(delay: 0)
        }
    }
    
    func imageRetrieved(cameraNumber: Int, image: NSImage) {
        if let bulletTimeCapture = bulletTimeCapture {
            syncQueue.sync {
                bulletTimeCapture.addImageFromCamera(cameraNumber: cameraNumber, image: image)
            }
            
            if (bulletTimeCapture.hasImagesForEachCamera()) {
                self.delegate?.bulletTimeCaptureReady(capture: bulletTimeCapture)
            }
        }
    }
}

protocol CameraImageRetrieverCollectionDelegate {
    func bulletTimeCaptureReady(capture: BulletTimeCapture)
}
