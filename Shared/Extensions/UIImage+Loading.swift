//
//  UIImage+Loading.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/19/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func getImagePath( imageName: String ) -> String {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        if let documentDirectory: URL = urls.first {
            let imagePath = documentDirectory.appendingPathComponent(AppUISettings.thumbnailFolder, isDirectory: true).appendingPathComponent( imageName + ".jpg" )
            return imagePath.absoluteString
        }
        
        return ""
    }
    
    static func getImageURL( imageName: String) -> URL {
        // declare image location
        let imagePath = getImagePath( imageName: imageName )
        let imageUrl = URL.init(string: imagePath)!
        
        return imageUrl
    }
    
    static func getImageFor(imageName: String) -> UIImage? {
        //debugPrint("looking getImagePath: " + getImagePath(imageName: imageName))
        let fileManager = FileManager.default
        // check if the image is stored already
        if fileManager.fileExists(atPath: getImageURL(imageName: imageName).path ) {
            //debugPrint("UIIMAGE.load!")
            if let imageData: Data = try? Data(contentsOf: getImageURL(imageName: imageName) ),
                let image: UIImage = UIImage(data: imageData, scale: UIScreen.main.scale) {
                return image
            } else {
                return nil
            }
        
        } else {
            return nil
        }
    }
    
    func save(imageName: String) -> Bool {
        return save(imageName: imageName, cornerCrop: false)
    }
    
    func save(imageName: String, cornerCrop: Bool ) -> Bool {
        // image has not been created yet: create it, store it, return it
        let imageUrl = UIImage.getImageURL(imageName: imageName)
        
        if (cornerCrop) {
            if let cgImage = self.cgImage {
                let toRect = CGRect.init(x: 200, y: 80, width: 200, height: 200)
                let croppedCGImage: CGImage = cgImage.cropping(to: toRect)!
                let croppedImage = UIImage(cgImage: croppedCGImage)
                return ((try? croppedImage.jpegData(compressionQuality: 0.75)?.write(to: imageUrl )) != nil)
            }
        }
        return ((try? self.jpegData(compressionQuality: 0.75)?.write(to: imageUrl )) != nil)
        
    }
    
    static func delete(imageName: String ) -> Bool {
        //debugPrint("looking getImagePath: " + getImagePath(imageName: imageName))
        let fileManager = FileManager.default
        // check if the image is stored already
        let url = getImageURL(imageName: imageName)
        if fileManager.fileExists(atPath: url.path ) {
            try? fileManager.removeItem(at: url)
            return true
        } else {
            return false
        }
    }
}
