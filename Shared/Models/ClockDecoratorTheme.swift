//
//  ClockDecoratorTheme.swift
//  SwissClock
//
//  Created by Mike Hill on 11/12/15.
//  Copyright © 2015 Mike Hill. All rights reserved.
//

//import Cocoa
import SceneKit
import SpriteKit

class ClockDecoratorTheme: NSObject {
    //model object to hold instances of a clock decorator theme
    
    var title:String
    
    var faceBackgroundType:FaceBackgroundTypes
    
    // types
    var hourHandType:HourHandTypes
    var minuteHandType:MinuteHandTypes
    var secondHandType:SecondHandTypes
    
    //options
    var minuteHandMovement:MinuteHandMovements
    var secondHandMovement:SecondHandMovements
    var shouldShowRomanNumeralText: Bool
    
    //tweaks
    var ringSettings: [ClockRingSetting]
    
    //NOTE: ANY CHANGES HERE NEED TO BE MADE IN CLOCKFACESETTINGS
    
    init(jsonObj: JSON ) {
        self.title = jsonObj["title"].stringValue
        
        self.faceBackgroundType = FaceBackgroundTypes(rawValue: jsonObj["faceBackgroundType"].stringValue)!
        self.hourHandType = HourHandTypes(rawValue: jsonObj["hourHandType"].stringValue)!
        self.minuteHandType = MinuteHandTypes(rawValue: jsonObj["minuteHandType"].stringValue)!
        self.secondHandType = SecondHandTypes(rawValue: jsonObj["secondHandType"].stringValue)!
        
        if (jsonObj["minuteHandMovement"] != JSON.null) {
            self.minuteHandMovement = MinuteHandMovements(rawValue: jsonObj["minuteHandMovement"].stringValue)!
        } else {
            self.minuteHandMovement = MinuteHandMovements.MinuteHandMovementStep
        }
        self.secondHandMovement = SecondHandMovements(rawValue: jsonObj["secondHandMovement"].stringValue)!
        self.shouldShowRomanNumeralText = jsonObj[ "shouldShowRomanNumeralText" ].boolValue
        
        // parse the ringSettings
        self.ringSettings = [ClockRingSetting]()
        
        if let ringSettingsSerializedArray = jsonObj["ringSettings"].array {
            for ringSettingSerialized in ringSettingsSerializedArray {
                let newRingSetting = ClockRingSetting.init(jsonObj: ringSettingSerialized)
                self.ringSettings.append( newRingSetting )
            }
        }
        
        super.init()
    }

}
