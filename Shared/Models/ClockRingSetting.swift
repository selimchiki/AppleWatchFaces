//
//  ClockRingSetting.swift
//  SwissClock
//
//  Created by Mike Hill on 3/10/16.
//  Copyright © 2016 Mike Hill. All rights reserved.
//

//import SceneKit
import SpriteKit

//different types of things that can be assigned to a ring on the clock face
enum RingTypes: String {
    case RingTypeShapeNode, RingTypeTextNode, RingTypeTextRotatingNode, RingTypeCircle, RingTypeSpacer
    
    static let userSelectableValues = [RingTypeShapeNode, RingTypeTextNode, RingTypeTextRotatingNode, RingTypeCircle, RingTypeSpacer]
}

//different types of shapes rings can render in
enum RingRenderShapes: String {
    case RingRenderShapeCircle, RingRenderShapeRoundedRect
    
    static let userSelectableValues = [RingRenderShapeCircle, RingRenderShapeRoundedRect]
}

class ClockRingSetting: NSObject {
    
    static func ringTotalOptions() -> [String] {
        return [ "60", "24", "12", "4", "2" ]
    }
    
    static func ringPatterns() -> [String:NSArray] {
        return [
            "all on":[1],
            "all off":[0],
            "show every 3rd": [1,0,0],
            "hide every 3rd": [0,1,1],
            "show every 5th":[1,0,0,0,0],
            "hide every 5th":[0,1,1,1,1],
            "alternate off":[0,1],
            "alternate on":[1,0]
        ]
    }
    
    static func descriptionForRingPattern(_ ringPatternToFind: [Int]) -> String {
        let indexOfPattern = ClockRingSetting.ringPatternKeys().index( of: ringPatternToFind as NSArray )!
        return ringPatternDescriptions()[ indexOfPattern ]
    }
    
    static func patternForRingPatternDescription(_ ringPatternDescription: String) -> [Int] {
        let indexOfPatternDescription = ClockRingSetting.ringPatternDescriptions().index( of: ringPatternDescription )!
        return ringPatternKeys()[ indexOfPatternDescription ] as! [Int]
    }
    
    static func ringPatternDescriptions() -> [String] {
        var options = [String]()
        for (key,_) in ringPatterns() {
            options.append(key)
        }
        return options
    }
    
    static func ringPatternKeys() -> [NSArray] {
        var options = [NSArray]()
        for (_,values) in ringPatterns() {
            options.append(values)
        }
        return options
    }
    
    static func descriptionForRingType(_ nodeType: RingTypes) -> String {
        var typeDescription = ""
        
        if (nodeType == RingTypes.RingTypeShapeNode)  { typeDescription = "Shape" }
        if (nodeType == RingTypes.RingTypeTextNode)  { typeDescription = "Number Text" }
        if (nodeType == RingTypes.RingTypeTextRotatingNode)  { typeDescription = "Number Text" }
        if (nodeType == RingTypes.RingTypeCircle )  { typeDescription = "Circle Shape" }
        if (nodeType == RingTypes.RingTypeSpacer )  { typeDescription = "Empty Space" }
        
        return typeDescription
    }
    
    static func ringTypeDescriptions() -> [String] {
        var typeDescriptionsArray = [String]()
        for nodeType in RingTypes.userSelectableValues {
            typeDescriptionsArray.append(descriptionForRingType(nodeType))
        }
        
        return typeDescriptionsArray
    }
    
    static func ringTypeKeys() -> [String] {
        var typeKeysArray = [String]()
        for nodeType in RingTypes.userSelectableValues {
            typeKeysArray.append(nodeType.rawValue)
        }
        
        return typeKeysArray
    }
    
    static func descriptionForRingRenderShapes(_ nodeType: RingRenderShapes) -> String {
        var typeDescription = ""
        
        if (nodeType == RingRenderShapes.RingRenderShapeCircle)  { typeDescription = "Circle" }
        if (nodeType == RingRenderShapes.RingRenderShapeRoundedRect)  { typeDescription = "Rectangle" }
        
        return typeDescription
    }
    
    static func ringRenderShapesDescriptions() -> [String] {
        var typeDescriptionsArray = [String]()
        for nodeType in RingRenderShapes.userSelectableValues {
            typeDescriptionsArray.append(descriptionForRingRenderShapes(nodeType))
        }
        
        return typeDescriptionsArray
    }
    
    static func ringRenderShapesKeys() -> [String] {
        var typeKeysArray = [String]()
        for nodeType in RingRenderShapes.userSelectableValues {
            typeKeysArray.append(nodeType.rawValue)
        }
        
        return typeKeysArray
    }
    
    //MARK: vars
    
    var ringType: RingTypes

    var ringMaterialDesiredThemeColorIndex: Int = 0
    
    var ringWidth: Float
    var ringPattern: [Int]
    var ringPatternTotal: Int
    
    var indicatorType: FaceIndicatorTypes
    var indicatorSize: Float
    
    var textType: NumberTextTypes
    var textSize : Float
    
    //MARK: init
    
    init(ringType: RingTypes,
        ringMaterialDesiredThemeColorIndex: Int,
        
        ringWidth: Float,
        ringPattern: [Int],
        ringPatternTotal: Int,
        
        indicatorType: FaceIndicatorTypes,
        indicatorSize: Float,
        
        textType: NumberTextTypes,
        textSize: Float
        )
    {
        self.ringType = ringType

        self.ringMaterialDesiredThemeColorIndex = ringMaterialDesiredThemeColorIndex
        self.ringWidth = ringWidth
        self.ringPattern = ringPattern
        self.ringPatternTotal = ringPatternTotal
        
        self.indicatorType = indicatorType
        self.indicatorSize = indicatorSize
        
        self.textType = textType
        self.textSize = textSize
        
        super.init()
    }

    //MARK: defaults
    static func defaults() -> ClockRingSetting {
        return ClockRingSetting.init(
            ringType: RingTypes.RingTypeShapeNode,
            ringMaterialDesiredThemeColorIndex: 0,
            ringWidth: 0.075,
            ringPattern: [1],
            ringPatternTotal: 12,
            
            indicatorType: FaceIndicatorTypes.FaceIndicatorTypeBox,
            indicatorSize: 0.15,
            
            textType:  NumberTextTypes.NumberTextTypeHelvica,
            textSize: 0.2)
    }
    
    //MARK: serialization
    
    //init from serialized
    convenience init( jsonObj: JSON ) {
        
        //print("minuteTextType", jsonObj["minuteTextType"].stringValue)
        
        var ringMaterialDesiredThemeColorIndex = 0
        //if jsonObj[ "ringMaterialDesiredThemeColorIndex" ] {
            ringMaterialDesiredThemeColorIndex = jsonObj[ "ringMaterialDesiredThemeColorIndex" ].intValue
        //}
        
        self.init(
            ringType: RingTypes(rawValue: jsonObj["ringType"].stringValue)!,
            
            ringMaterialDesiredThemeColorIndex : ringMaterialDesiredThemeColorIndex,
            
            ringWidth : Float( jsonObj[ "ringWidth" ].floatValue ),
            ringPattern: ClockRingSetting.patternArrayFromSerializedArray( jsonObj[ "ringPattern" ] ),
            ringPatternTotal: Int( jsonObj[ "ringPatternTotal" ].intValue ),
            
            indicatorType: FaceIndicatorTypes(rawValue: jsonObj["indicatorType"].stringValue)!,
            indicatorSize : Float( jsonObj[ "indicatorSize" ].floatValue ),
            
            textType: NumberTextTypes(rawValue: jsonObj["textType"].stringValue)!,
            textSize: Float( jsonObj[ "textSize" ].floatValue )
        )
    }
    
    func serializedSettings() -> NSDictionary {
        var serializedDict = [String:AnyObject]()
        
        serializedDict[ "ringType" ] = self.ringType.rawValue as AnyObject

        serializedDict[ "ringMaterialDesiredThemeColorIndex" ] = self.ringMaterialDesiredThemeColorIndex as AnyObject
        
        serializedDict[ "ringWidth" ] = self.ringWidth.description as AnyObject
        serializedDict[ "ringPattern" ] = self.ringPattern as AnyObject
        serializedDict[ "ringPatternTotal" ] = self.ringPatternTotal.description as AnyObject
        
        serializedDict[ "indicatorType" ] = self.indicatorType.rawValue as AnyObject
        serializedDict[ "indicatorSize" ] = self.indicatorSize.description as AnyObject
        
        serializedDict[ "textType" ] = self.textType.rawValue as AnyObject
        serializedDict[ "textSize" ] = self.textSize.description as AnyObject
        
        return serializedDict as NSDictionary
    }
    
    static func patternArrayFromSerializedArray( _ serializedArrayObj: JSON ) -> [Int] {
        var intArray = [Int]()
        if let clockPatternSerializedArray = serializedArrayObj.array {
            for clockPatternSerialized in clockPatternSerializedArray {
                intArray.append( Int( clockPatternSerialized.int16Value ) )
            }
        }
        return intArray
    }

}
