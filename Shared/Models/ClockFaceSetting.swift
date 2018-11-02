//
//  ClockFaceSetting.swift
//  SwissClock
//
//  Created by Mike Hill on 11/12/15.
//  Copyright © 2015 Mike Hill. All rights reserved.
//

//import Cocoa
import SceneKit
import SpriteKit

class ClockFaceSetting: NSObject {
    
    func applyDecoratorTheme( _ theme: ClockDecoratorTheme) {
        //set the theme title in case we want to display it in the form
        self.hourHandType = theme.hourHandType
        self.minuteHandType = theme.minuteHandType
        self.secondHandType = theme.secondHandType
        
        self.minuteHandMovement = theme.minuteHandMovement
        self.secondHandMovement = theme.secondHandMovement
        self.shouldShowRomanNumeralText = theme.shouldShowRomanNumeralText
        
        //get material from first ring
        var ringMaterialName = "#FF0000"
        
        if (self.ringSettings.count > 0 ) {
            ringMaterialName = self.ringSettings[0].ringMaterialName
        }
        self.ringSettings = theme.ringSettings
        
        //override new materials
        for ringSetting in self.ringSettings {
            ringSetting.ringMaterialName = ringMaterialName
        }
    }
    
    //model object to hold instances of a clock face settings
    
    //NOTE: ANY CHANGES HERE PROBABLY NEED TO BE MADE IN DECORATOR THEMES
    
    var minuteHandMaterialName: String
    var secondHandMaterialName: String
    var hourHandMaterialName: String
    
    // types
    var hourHandType:HourHandTypes
    var minuteHandType:MinuteHandTypes
    var secondHandType:SecondHandTypes
    
    //options
    var secondHandMovement:SecondHandMovements
    var minuteHandMovement:MinuteHandMovements
    var shouldShowRomanNumeralText: Bool
    
    var ringSettings: [ClockRingSetting]
    
    //tweaks
    
    init(secondHandMaterialName: String,
        hourHandMaterialName: String,
        minuteHandMaterialName: String,
        
        hourHandType: HourHandTypes,
        minuteHandType: MinuteHandTypes,
        secondHandType: SecondHandTypes,
        
        minuteHandMovement: MinuteHandMovements,
        secondHandMovement: SecondHandMovements,
        shouldShowRomanNumeralText: Bool,
        
        ringSettings: [ClockRingSetting]
        )
    {
        self.secondHandMaterialName = secondHandMaterialName
        self.hourHandMaterialName = hourHandMaterialName
        self.minuteHandMaterialName = minuteHandMaterialName
        
        self.hourHandType = hourHandType
        self.minuteHandType = minuteHandType
        self.secondHandType = secondHandType
    
        self.minuteHandMovement = minuteHandMovement
        self.secondHandMovement = secondHandMovement
        self.shouldShowRomanNumeralText = shouldShowRomanNumeralText
        
        self.ringSettings = ringSettings
    
        super.init()
    }

    static func defaults() -> ClockFaceSetting {
        return ClockFaceSetting.init(
            secondHandMaterialName: "#FF0000FF",
            hourHandMaterialName: "#000000FF",
            minuteHandMaterialName: "#000000FF",
            
            hourHandType: HourHandTypes.HourHandTypeSwiss,
            minuteHandType: MinuteHandTypes.MinuteHandTypeSwiss,
            secondHandType: SecondHandTypes.SecondHandTypeRail,
            
            minuteHandMovement: MinuteHandMovements.MinuteHandMovementStep,
            secondHandMovement: SecondHandMovements.SecondHandMovementStepOver,
            shouldShowRomanNumeralText: false,
            
            ringSettings: [ ClockRingSetting.defaults() ]
        )
    }
    
    static func random() -> ClockFaceSetting {
        
        return ClockFaceSetting.init(
            secondHandMaterialName: "#FF0000FF",
            hourHandMaterialName: "#000000FF",
            minuteHandMaterialName: "#000000FF",
            
            hourHandType: HourHandTypes.HourHandTypeSwiss,
            minuteHandType: MinuteHandTypes.MinuteHandTypeSwiss,
            secondHandType: SecondHandTypes.random(),
            
            minuteHandMovement: MinuteHandMovements.random(),
            secondHandMovement: SecondHandMovements.random(),
            shouldShowRomanNumeralText: false,
        
            ringSettings: [ ClockRingSetting.defaults() ]
        )
    }
    
    //init from serialized
    convenience init( jsonObj: JSON ) {
        
        //print("minuteTextType", jsonObj["minuteTextType"].stringValue)
        
        // parse the ringSettings
        var ringSettings = [ClockRingSetting]()
        
        if let ringSettingsSerializedArray = jsonObj["ringSettings"].array {
            for ringSettingSerialized in ringSettingsSerializedArray {
                let newRingSetting = ClockRingSetting.init(jsonObj: ringSettingSerialized)
                ringSettings.append( newRingSetting )
                }
        }
        
        var minuteHandMovement = MinuteHandMovements.MinuteHandMovementStep
        if (jsonObj["minuteHandMovement"] != JSON.null) {
            minuteHandMovement = MinuteHandMovements(rawValue: jsonObj["minuteHandMovement"].stringValue)!
        }
        
        self.init(
            secondHandMaterialName: jsonObj["secondHandMaterialName"].stringValue,
            hourHandMaterialName: jsonObj["hourHandMaterialName"].stringValue,
            minuteHandMaterialName: jsonObj["minuteHandMaterialName"].stringValue,
            
            hourHandType: HourHandTypes(rawValue: jsonObj["hourHandType"].stringValue)!,
            minuteHandType: MinuteHandTypes(rawValue: jsonObj["minuteHandType"].stringValue)!,
            secondHandType: SecondHandTypes(rawValue: jsonObj["secondHandType"].stringValue)!,
            
            minuteHandMovement: minuteHandMovement,
            secondHandMovement: SecondHandMovements(rawValue: jsonObj["secondHandMovement"].stringValue)!,
            shouldShowRomanNumeralText: jsonObj[ "shouldShowRomanNumeralText" ].boolValue ,
            
            ringSettings : ringSettings
        )
    }
    
    func serializedSettings() -> NSDictionary {
        var serializedDict = [String:AnyObject]()
        
        serializedDict[ "secondHandMaterialName" ] = self.secondHandMaterialName as AnyObject
        serializedDict[ "hourHandMaterialName" ] = self.hourHandMaterialName as AnyObject
        serializedDict[ "minuteHandMaterialName" ] = self.minuteHandMaterialName as AnyObject
    
        serializedDict[ "hourHandType" ] = self.hourHandType.rawValue as AnyObject
        serializedDict[ "minuteHandType" ] = self.minuteHandType.rawValue as AnyObject
        serializedDict[ "secondHandType" ] = self.secondHandType.rawValue as AnyObject
        
        serializedDict[ "minuteHandMovement" ] = self.minuteHandMovement.rawValue as AnyObject
        serializedDict[ "secondHandMovement" ] = self.secondHandMovement.rawValue as AnyObject
        serializedDict[ "shouldShowRomanNumeralText" ] = NSNumber.init(value: self.shouldShowRomanNumeralText as Bool)
        
        var ringSettingsArray = [NSDictionary]()
        for ringSetting in self.ringSettings {
            ringSettingsArray.append ( ringSetting.serializedSettings() )
        }
        serializedDict[ "ringSettings" ] = ringSettingsArray as AnyObject
        
        return serializedDict as NSDictionary
    }

}
