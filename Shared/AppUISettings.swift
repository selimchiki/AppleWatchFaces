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
    static let settingLineWidthBeforeScale:CGFloat = 3.0
    
    //corner radius for thumbnails in settings
    static let cornerRadiusForSettingsThumbs:CGFloat = 16.0
    
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
    
    //time settings used when generating thumbnail screen shots
    //  ( focuses goods in upper-right )
    static let screenShotSeconds:CGFloat = 4
    static let screenShotHour:CGFloat = 12
    static let screenShotMinutes:CGFloat = 7
    
    //some other DRY settings
    static let thumbnailFolder = "thumbs"
    
    static func deleteAllFolders() {
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        let docsURL = dirPaths[0]
        let newDir = docsURL.appendingPathComponent(AppUISettings.thumbnailFolder)
        
        do{
            try filemgr.removeItem(at: newDir)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    static func createFolders() {
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        let docsURL = dirPaths[0]
        let newDir = docsURL.appendingPathComponent(AppUISettings.thumbnailFolder).path
        
        do{
            try filemgr.createDirectory(atPath: newDir,withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    static func copyFolders() {
        let filemgr = FileManager.default
        
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        let docsURL = dirPaths[0]
        
        let folderPath = Bundle.main.resourceURL!.path
        let docsFolder = docsURL.appendingPathComponent(AppUISettings.thumbnailFolder).path
        copyFiles(pathFromBundle: folderPath, pathDestDocs: docsFolder)
    }
    
    static func copyFiles(pathFromBundle : String, pathDestDocs: String) {
        let fileManagerIs = FileManager.default
        
        do {
            let filelist = try fileManagerIs.contentsOfDirectory(atPath: pathFromBundle)
            try? fileManagerIs.copyItem(atPath: pathFromBundle, toPath: pathDestDocs)
            
            for filename in filelist {
                if URL.init(string: filename)?.pathExtension == "jpg"  {
                    try? fileManagerIs.copyItem(atPath: "\(pathFromBundle)/\(filename)", toPath: "\(pathDestDocs)/\(filename)")
                }
            }
        } catch {
            print("\nError\n")
        }
    }

}
