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

//model object to hold instances of a clock face settings
class ClockFaceSetting: NSObject {
    
    func applyDecoratorTheme( _ theme: ClockDecoratorTheme) {
        //set the theme title in case we want to display it in the form
        self.hourHandType = theme.hourHandType
        self.minuteHandType = theme.minuteHandType
        self.secondHandType = theme.secondHandType
        
        self.minuteHandMovement = theme.minuteHandMovement
        self.secondHandMovement = theme.secondHandMovement
        self.shouldShowRomanNumeralText = theme.shouldShowRomanNumeralText
        
        self.ringSettings = theme.ringSettings
    }
    
    //NOTE: ANY CHANGES HERE PROBABLY NEED TO BE MADE IN DECORATOR THEMES
    
    var minuteHandMaterialName: String
    var secondHandMaterialName: String
    var hourHandMaterialName: String
    var handOutlineMaterialName: String
    
    // types
    var hourHandType:HourHandTypes
    var minuteHandType:MinuteHandTypes
    var secondHandType:SecondHandTypes
    
    //options
    var secondHandMovement:SecondHandMovements
    var minuteHandMovement:MinuteHandMovements
    var shouldShowRomanNumeralText: Bool
    var shouldShowHandOutlines: Bool
    
    var ringRenderShape: RingRenderShapes
    var ringMaterials: [String]
    var ringSettings: [ClockRingSetting]
    
    //tweaks
    
    init(secondHandMaterialName: String,
        hourHandMaterialName: String,
        minuteHandMaterialName: String,
        
        handOutlineMaterialName: String,
        
        hourHandType: HourHandTypes,
        minuteHandType: MinuteHandTypes,
        secondHandType: SecondHandTypes,
        
        minuteHandMovement: MinuteHandMovements,
        secondHandMovement: SecondHandMovements,
        shouldShowRomanNumeralText: Bool,
        shouldShowHandOutlines: Bool,
        
        ringRenderShape: RingRenderShapes,
        ringMaterials: [String],
        ringSettings: [ClockRingSetting]
        )
    {
        self.secondHandMaterialName = secondHandMaterialName
        self.hourHandMaterialName = hourHandMaterialName
        self.minuteHandMaterialName = minuteHandMaterialName
        self.handOutlineMaterialName = handOutlineMaterialName
        
        self.hourHandType = hourHandType
        self.minuteHandType = minuteHandType
        self.secondHandType = secondHandType
    
        self.minuteHandMovement = minuteHandMovement
        self.secondHandMovement = secondHandMovement
        self.shouldShowRomanNumeralText = shouldShowRomanNumeralText
        self.shouldShowHandOutlines = shouldShowHandOutlines
        
        self.hourHandMaterialName = hourHandMaterialName
        self.minuteHandMaterialName = minuteHandMaterialName
        
        self.ringRenderShape = ringRenderShape
        self.ringMaterials = ringMaterials
        self.ringSettings = ringSettings
    
        super.init()
    }

    static func defaults() -> ClockFaceSetting {
        return ClockFaceSetting.init(
            secondHandMaterialName: "#FF0000FF",
            hourHandMaterialName: "#FFFFFFFF",
            minuteHandMaterialName: "#FFFFFFFF",
            handOutlineMaterialName: "#8e8e8eff",
            
            hourHandType: HourHandTypes.HourHandTypeSwiss,
            minuteHandType: MinuteHandTypes.MinuteHandTypeSwiss,
            secondHandType: SecondHandTypes.SecondHandTypeRail,
            
            minuteHandMovement: MinuteHandMovements.MinuteHandMovementStep, //lowest power impact
            secondHandMovement: SecondHandMovements.SecondHandMovementStep, //lowest power impact
            shouldShowRomanNumeralText: false,
            shouldShowHandOutlines: false,
            
            ringRenderShape: RingRenderShapes.RingRenderShapeCircle,
            ringMaterials: [ "#FFFFFFFF","#e2e2e2ff","#c6c6c6ff" ],
            ringSettings: [ ClockRingSetting.defaults() ]
        )
    }
    
    static func random() -> ClockFaceSetting {
        
        return ClockFaceSetting.init(
            secondHandMaterialName: "#FF0000FF",
            hourHandMaterialName: "#000000FF",
            minuteHandMaterialName: "#000000FF",
            handOutlineMaterialName: "#8e8e8eff",
            
            hourHandType: HourHandTypes.HourHandTypeSwiss,
            minuteHandType: MinuteHandTypes.MinuteHandTypeSwiss,
            secondHandType: SecondHandTypes.random(),
            
            minuteHandMovement: MinuteHandMovements.random(),
            secondHandMovement: SecondHandMovements.random(),
            shouldShowRomanNumeralText: false,
            shouldShowHandOutlines: false,
        
            ringRenderShape: RingRenderShapes.RingRenderShapeCircle,
            ringMaterials: [ "#FFFFFFFF","#e2e2e2ff","#c6c6c6ff" ],
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
        
        var ringMaterialsTemp = [String]()
        if let ringMaterialsSerializedArray = jsonObj["ringMaterials"].array {
            for ringMaterialsSerialized in ringMaterialsSerializedArray {
                ringMaterialsTemp.append( ringMaterialsSerialized.stringValue )
            }
        }
        
        var minuteHandMovement = MinuteHandMovements.MinuteHandMovementStep
        if (jsonObj["minuteHandMovement"] != JSON.null) {
            minuteHandMovement = MinuteHandMovements(rawValue: jsonObj["minuteHandMovement"].stringValue)!
        }
        
        var ringRenderShape = RingRenderShapes.RingRenderShapeCircle
        if (jsonObj["ringRenderShape"] != JSON.null) {
            ringRenderShape = RingRenderShapes(rawValue: jsonObj["ringRenderShape"].stringValue)!
        }
        
        self.init(
            secondHandMaterialName: jsonObj["secondHandMaterialName"].stringValue,
            hourHandMaterialName: jsonObj["hourHandMaterialName"].stringValue,
            minuteHandMaterialName: jsonObj["minuteHandMaterialName"].stringValue,
            handOutlineMaterialName: jsonObj["handOutlineMaterialName"].stringValue,
            
            hourHandType: HourHandTypes(rawValue: jsonObj["hourHandType"].stringValue)!,
            minuteHandType: MinuteHandTypes(rawValue: jsonObj["minuteHandType"].stringValue)!,
            secondHandType: SecondHandTypes(rawValue: jsonObj["secondHandType"].stringValue)!,
            
            minuteHandMovement: minuteHandMovement,
            secondHandMovement: SecondHandMovements(rawValue: jsonObj["secondHandMovement"].stringValue)!,
            shouldShowRomanNumeralText: jsonObj[ "shouldShowRomanNumeralText" ].boolValue ,
            shouldShowHandOutlines: jsonObj[ "shouldShowHandOutlines" ].boolValue ,
            
            ringRenderShape: ringRenderShape,
            ringMaterials : ringMaterialsTemp,
            ringSettings : ringSettings
        )
    }
    
    func serializedSettings() -> NSDictionary {
        var serializedDict = [String:AnyObject]()
        
        serializedDict[ "secondHandMaterialName" ] = self.secondHandMaterialName as AnyObject
        serializedDict[ "hourHandMaterialName" ] = self.hourHandMaterialName as AnyObject
        serializedDict[ "minuteHandMaterialName" ] = self.minuteHandMaterialName as AnyObject
        serializedDict[ "handOutlineMaterialName" ] = self.handOutlineMaterialName as AnyObject
    
        serializedDict[ "hourHandType" ] = self.hourHandType.rawValue as AnyObject
        serializedDict[ "minuteHandType" ] = self.minuteHandType.rawValue as AnyObject
        serializedDict[ "secondHandType" ] = self.secondHandType.rawValue as AnyObject
        
        serializedDict[ "minuteHandMovement" ] = self.minuteHandMovement.rawValue as AnyObject
        serializedDict[ "secondHandMovement" ] = self.secondHandMovement.rawValue as AnyObject
        serializedDict[ "shouldShowRomanNumeralText" ] = NSNumber.init(value: self.shouldShowRomanNumeralText as Bool)
        serializedDict[ "shouldShowHandOutlines" ] = NSNumber.init(value: self.shouldShowHandOutlines as Bool)
        
        serializedDict[ "ringRenderShape" ] = self.ringRenderShape.rawValue as AnyObject
        serializedDict[ "ringMaterials" ] = self.ringMaterials as AnyObject

        var ringSettingsArray = [NSDictionary]()
        for ringSetting in self.ringSettings {
            ringSettingsArray.append ( ringSetting.serializedSettings() )
        }
        serializedDict[ "ringSettings" ] = ringSettingsArray as AnyObject
        
        return serializedDict as NSDictionary
    }

}
