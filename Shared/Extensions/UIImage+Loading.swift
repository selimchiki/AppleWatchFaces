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
        let imagePath: String = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/thumbs/\(imageName).jpg"
        return imagePath
    }
    
    func getImageURL( imageName: String) -> URL {
        // declare image location
        let imagePath = getImagePath( imageName: imageName )
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
        
        return imageUrl
    }
    
    func load(imageName: String) -> UIImage? {
        // check if the image is stored already
        if FileManager.default.fileExists(atPath: getImagePath(imageName: imageName) ),
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
        return ((try? self.jpegData(compressionQuality: 0.7)?.write(to: imageUrl )) != nil)
        //return ((try? self.pngData()?.write(to: imageUrl )) != nil)
    }
}
