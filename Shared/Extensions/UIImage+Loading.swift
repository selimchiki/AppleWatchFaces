//
//  UIImage+Loading.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/19/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit

extension UIImage {
    
    func getImagePath( imageName: String ) -> String {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        if let documentDirectory: URL = urls.first {
            let imagePath = documentDirectory.appendingPathComponent(AppUISettings.thumbnailFolder, isDirectory: true).appendingPathComponent( imageName + ".jpg" )
            return imagePath.absoluteString
        }
        
        return ""
    }
    
    func getImageURL( imageName: String) -> URL {
        // declare image location
        let imagePath = getImagePath( imageName: imageName )
        let imageUrl = URL.init(string: imagePath)!
        
        return imageUrl
    }
    
    func load(imageName: String) -> UIImage? {
        let fileManager = FileManager.default
        // check if the image is stored already
        if fileManager.fileExists(atPath: getImagePath(imageName: imageName) ),
            let imageData: Data = try? Data(contentsOf: getImageURL(imageName: imageName) ),
            let image: UIImage = UIImage(data: imageData, scale: UIScreen.main.scale) {
            return image
        } else {
            return nil
        }
    }
    
    func save(imageName: String ) -> Bool {
        // image has not been created yet: create it, store it, return it
        let imageUrl = getImageURL(imageName: imageName)
        debugPrint("attempting save if image: "+imageUrl.absoluteString)
        return ((try? self.jpegData(compressionQuality: 0.75)?.write(to: imageUrl )) != nil)
        //return ((try? self.pngData()?.write(to: imageUrl )) != nil)
    }
}
