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

}
