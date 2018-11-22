//
//  AppUISettings.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/11/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import Foundation

import SpriteKit

class AppUISettings: NSObject {
    
    /*
    These are "theme" settings for the app overall.  Items go here that will be set ( or overriden ) in code that will affect the look and feel of the app.
    Eventually, we might want to load this from JSON or a plist ? */
 
    //the color used when highlighting the cell items
    static let settingHighlightColor:String = "#38ff9b"

    //line width for settings SKNodes strokes ( before scaling )
    static let settingLineWidthBeforeScale:CGFloat = 4.0
    
    static let materialFiles = ["vinylAlbum.jpg", "watchGears.jpg", "brass.jpg", "copper.jpg","kork.jpg", "light-wood.jpg",
                                "wallpaper70s.jpg","wallpaperFlower.jpg","watchGears.jpg"]
    
    static func materialIsColor( materialName: String ) -> Bool {
        if (materialName.lengthOfBytes(using: String.Encoding.utf8) > 0) {
            let index = materialName.index(materialName.startIndex, offsetBy: 1)
            let firstChar = materialName.substring(to: index)
            
            if ( firstChar == "#") {
                return true
            }
        }
        
        return false
    }
    
    //some other DRY settings
    static let thumbnailFolder = "thumbs"

}
