//
//  ClockSetting.swift
//  SwissClock
//
//  Created by Mike Hill on 11/12/15.
//  Copyright © 2015 Mike Hill. All rights reserved.
//

//import Cocoa
import SceneKit
import SpriteKit

class ClockSetting: NSObject {
    //model object to hold instances of a clock settings
    
    func applyColorTheme( _ theme: ClockColorTheme) {
        print("using color theme: ", theme.title)
        //set the theme title in case we want to display it in the form
        self.themeTitle = theme.title
        
        //take the them and apply it
        self.clockFaceMaterialName = theme.clockFaceMaterialName
        self.clockCasingMaterialName = theme.clockCasingMaterialName
        
        self.clockFaceSettings?.hourHandMaterialName = theme.hourHandMaterialName
        self.clockFaceSettings?.minuteHandMaterialName = theme.minuteHandMaterialName
        self.clockFaceSettings?.secondHandMaterialName = theme.secondHandMaterialName
        
        self.clockFaceSettings?.ringMaterials = theme.ringMaterials
    }
    
    func applyDecoratorTheme ( _ theme: ClockDecoratorTheme ) {
        print("using face theme: ", theme.title)
        self.decoratorThemeTitle = theme.title
        self.faceBackgroundType = theme.faceBackgroundType
        
        self.clockFaceSettings?.applyDecoratorTheme( theme )
    }
    
    func toJSONData() -> Data? {
        let settingsDict = self.serializedSettings()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: settingsDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            return jsonData
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func toJSON() -> JSON? {
        let settingsDict = self.serializedSettings()
        //let settingsData = NSKeyedArchiver.archivedDataWithRootObject(settingsDict)
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: settingsDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonObj = try! JSON(data: jsonData)
            return jsonObj
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func clone() -> ClockSetting? {
        return clone(keepUniqueID: true)
    }
    
    func clone( keepUniqueID: Bool ) -> ClockSetting? {
        // use JSON to clone it cause, you know , you can!
        
        let settingsDict = self.serializedSettings()
        //let settingsData = NSKeyedArchiver.archivedDataWithRootObject(settingsDict)
    
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: settingsDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonObj = try! JSON(data: jsonData)
            
            if jsonObj != JSON.null {
                let newSetting = ClockSetting.init(jsonObj: jsonObj)
                
                if !keepUniqueID {
                    //re-assing the uid
                    newSetting.uniqueID = UUID().uuidString
                }
                return newSetting
            } else {
                print("could not get json from clone, make sure that contains valid json.")
            }
        } catch let error as NSError {
            print(error)
        }
        
        print("could not get json from clone, make sure that contains valid json.")
        return nil
    }
    
    // background type
    var faceBackgroundType:FaceBackgroundTypes
    
    // face settings
    var clockFaceSettings:ClockFaceSetting?
    
    var title:String
    var themeTitle:String
    var decoratorThemeTitle:String
    
    var clockFaceMaterialName:String
    var clockCasingMaterialName:String
    
    var uniqueID:String
    
    //no uniqueID ( generate one )
    convenience init(clockFaceMaterialName: String,
                     faceBackgroundType: FaceBackgroundTypes,
                     clockCasingMaterialName: String,
                     clockFaceSettings: ClockFaceSetting,
                     title: String) {
        
        self.init(clockFaceMaterialName: clockFaceMaterialName,
                  faceBackgroundType: faceBackgroundType,
                  clockCasingMaterialName: clockCasingMaterialName,
                  clockFaceSettings: clockFaceSettings,
                  title: title ,
                  uniqueID: UUID().uuidString)
    }
    
    init(clockFaceMaterialName: String,
        faceBackgroundType: FaceBackgroundTypes,
        
        clockCasingMaterialName: String,
        
        clockFaceSettings: ClockFaceSetting,
        title: String,
        uniqueID: String)
    {
        self.clockFaceMaterialName = clockFaceMaterialName
        self.faceBackgroundType = faceBackgroundType
        self.clockFaceSettings = clockFaceSettings
        self.title = title
        self.clockCasingMaterialName = clockCasingMaterialName
        self.themeTitle = ""
        self.decoratorThemeTitle = ""
        
        //create this on init
        self.uniqueID = uniqueID
        
        super.init()
    }
    
//    static func settingsByName( settingsName: String) -> ClockSetting {
//        let allSettings = self.allSettings()
//        
//        let theSetting = allSettings[settingsName]
//        
//        return theSetting!
//    }
    
    static func defaults() -> ClockSetting {
        return ClockSetting.init(
            clockFaceMaterialName: "#000000FF",
            faceBackgroundType: FaceBackgroundTypes.FaceBackgroundTypeFilled,
            
            clockCasingMaterialName: "#FF0000FF",
            
            clockFaceSettings: ClockFaceSetting.defaults(),
            title: "Untitled"
        )
    }
    
    func randomize( newColors: Bool, newBackground: Bool, newFace: Bool ) {
        if (newBackground) {
            self.faceBackgroundType = FaceBackgroundTypes.random()
        }
        if (newFace) {
            self.applyDecoratorTheme(UserClockSetting.randomDecoratorTheme())
        }
        if (newColors) {
            self.applyColorTheme(UserClockSetting.randomColorTheme())
        }
    
        //self.setTitleForRandomClock()
    }
    
    static func random() -> ClockSetting {

        let faceBackgroundType = FaceBackgroundTypes.random()
        let clockSetting = ClockSetting.init(
            clockFaceMaterialName: "#FFFFFFFF",
            faceBackgroundType: faceBackgroundType,

            clockCasingMaterialName: "#FF0000FF",

            clockFaceSettings: ClockFaceSetting.random(),
            title: "random"
        )

        //add a random theme
        let randoDecoTheme = UserClockSetting.randomDecoratorTheme() //UserClockSetting.sharedDecoratorThemeSettings[1]
        clockSetting.applyDecoratorTheme(randoDecoTheme)

        //add a random theme
        let randoTheme =  UserClockSetting.randomColorTheme() //UserClockSetting.sharedColorThemeSettings[0]
        clockSetting.applyColorTheme(randoTheme)

        clockSetting.setTitleForRandomClock()

        return clockSetting
    }
    
    //init from serialized
    convenience init( jsonObj: JSON ) {
        
        let faceBackgroundType = FaceBackgroundTypes(rawValue: jsonObj["faceBackgroundType"].stringValue)!
        
        self.init(
            clockFaceMaterialName: jsonObj["clockFaceMaterialName"].stringValue,
            faceBackgroundType: faceBackgroundType,
            
            clockCasingMaterialName: jsonObj["clockCasingMaterialName"].stringValue,
            
            clockFaceSettings: ClockFaceSetting.init(jsonObj: jsonObj["clockFaceSettings"]),
            title: jsonObj["title"].stringValue,
            uniqueID: jsonObj["uniqueID"].stringValue
        )
    
    }
    
    func setTitleForRandomClock() {
        self.title = "randomClock-" + String.random(20)
    }
    
    //returns a JSON serializable safe version ( 
    
    /*
    - Top level object is an NSArray or NSDictionary
    - All objects are NSString, NSNumber, NSArray, NSDictionary, or NSNull
    - All dictionary keys are NSStrings
    */
    
    //floats to a string (description) feels safest since we have cross platform floats w/ NSNumber to worry about

    func serializedSettings() -> NSDictionary {
        var serializedDict = [String:AnyObject]()
        
        serializedDict[ "title" ] = self.title as AnyObject
        serializedDict[ "uniqueID" ] = self.uniqueID as AnyObject
        serializedDict[ "clockFaceMaterialName" ] = self.clockFaceMaterialName as AnyObject
        serializedDict[ "faceBackgroundType" ] = self.faceBackgroundType.rawValue as AnyObject
        serializedDict[ "clockFaceSettings" ] = self.clockFaceSettings!.serializedSettings()
        
        serializedDict[ "clockCasingMaterialName" ] = self.clockCasingMaterialName as AnyObject
        
        
        return serializedDict as NSDictionary
    }

}
