//
//  ClockTheme.swift
//  SwissClock
//
//  Created by Mike Hill on 11/12/15.
//  Copyright © 2015 Mike Hill. All rights reserved.
//

//import Cocoa
import SceneKit
import SpriteKit

class ClockColorTheme: NSObject {
    //model object to hold instances of a clock theme
    
    var title:String
    
    var clockFaceMaterialName:String
    var clockCasingMaterialName:String
    
    var hourHandMaterialName:String
    var minuteHandMaterialName:String
    var secondHandMaterialName:String
    
    var ringMaterials: [ String ]
    
    init(jsonObj: JSON ) {
        
        self.title = jsonObj["title"].stringValue
        self.clockFaceMaterialName = jsonObj["clockFaceMaterialName"].stringValue
        self.clockCasingMaterialName = jsonObj["clockCasingMaterialName"].stringValue
        
        self.hourHandMaterialName = jsonObj["hourHandMaterialName"].stringValue
        self.minuteHandMaterialName = jsonObj["minuteHandMaterialName"].stringValue
        self.secondHandMaterialName = jsonObj["secondHandMaterialName"].stringValue
        
        self.ringMaterials = []
        if let ringSettingsSerializedArray = jsonObj["ringMaterials"].array {
            for ringSettingSerialized in ringSettingsSerializedArray {
                ringMaterials.append( ringSettingSerialized.stringValue )
            }
        }
    
        super.init()
    }
    
    func filename()->String {
        let newName = self.title.components(separatedBy: CharacterSet.alphanumerics.inverted).joined().lowercased()
        return newName
    }

}
