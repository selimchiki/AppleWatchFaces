//
//  HourIndicatorNode.swift
//  SwissClock
//
//  Created by Mike Hill on 11/11/15.
//  Copyright © 2015 Mike Hill. All rights reserved.
//

//import Cocoa
import SpriteKit
import SceneKit

enum FaceIndicatorTypes: String {
    case FaceIndicatorTypeTube, FaceIndicatorTypeSphere, FaceIndicatorTypeBox,
    FaceIndicatorTypeMediumBox, FaceIndicatorTypeFatBox, FaceIndicatorTypeCircle
    
    static let randomizableValues = [FaceIndicatorTypeTube, FaceIndicatorTypeSphere, FaceIndicatorTypeBox, FaceIndicatorTypeMediumBox, FaceIndicatorTypeFatBox]
    static let userSelectableValues = [FaceIndicatorTypeTube, FaceIndicatorTypeSphere, FaceIndicatorTypeBox, FaceIndicatorTypeMediumBox, FaceIndicatorTypeFatBox]
    
    static func random() -> FaceIndicatorTypes {
        let randomIndex = Int(arc4random_uniform(UInt32(randomizableValues.count)))
        return randomizableValues[randomIndex]
    }
}

class FaceIndicatorNode: SKSpriteNode {
    
    static func descriptionForType(_ nodeType: FaceIndicatorTypes) -> String {
        var typeDescription = ""
        
        if (nodeType == FaceIndicatorTypes.FaceIndicatorTypeTube)  { typeDescription = "Tube" }
        if (nodeType == FaceIndicatorTypes.FaceIndicatorTypeSphere)  { typeDescription = "Sphere" }
        if (nodeType == FaceIndicatorTypes.FaceIndicatorTypeBox)  { typeDescription = "Thin Box" }
        if (nodeType == FaceIndicatorTypes.FaceIndicatorTypeMediumBox )  { typeDescription = "Medium Box" }
        if (nodeType == FaceIndicatorTypes.FaceIndicatorTypeFatBox)  { typeDescription = "Fat Box" }
        
        return typeDescription
    }
    
    static func typeDescriptions() -> [String] {
        var typeDescriptionsArray = [String]()
        for nodeType in FaceIndicatorTypes.userSelectableValues {
            typeDescriptionsArray.append(descriptionForType(nodeType))
        }
        
        return typeDescriptionsArray
    }
    
    static func typeKeys() -> [String] {
        var typeKeysArray = [String]()
        for nodeType in FaceIndicatorTypes.userSelectableValues {
            typeKeysArray.append(nodeType.rawValue)
        }
        
        return typeKeysArray
    }
    
//    override init() {
//        super.init(texture: nil, color: SKColor.clear, size: CGSize.init())
//    }
    
    init(indicatorType: FaceIndicatorTypes, size: Float, fillColor: SKColor) {
        
        super.init(texture: nil, color: SKColor.clear, size: CGSize.init())
        
        self.name = "FaceIndicator"
        let sizeMultiplier:CGFloat = SKWatchScene.sizeMulitplier
        
        if (indicatorType == FaceIndicatorTypes.FaceIndicatorTypeBox) {
            let w = CGFloat( size * Float(0.1) )
            let h = CGFloat( size * Float(0.7) )
            let shapeNode = SKShapeNode.init(rect: CGRect.init(x: 0, y: 0, width: w * sizeMultiplier, height: h * sizeMultiplier))
            shapeNode.fillColor = fillColor
            shapeNode.strokeColor = SKColor.clear
            shapeNode.position = CGPoint.init(x: -(w * sizeMultiplier)/2, y: -(h * sizeMultiplier)/2)
            self.addChild(shapeNode)
            
            //self.geometry = SCNBox.init(width: w, height: h, length: 0.002, chamferRadius: 0)
        }
        
        if (indicatorType == FaceIndicatorTypes.FaceIndicatorTypeMediumBox) {
            let w = CGFloat( size * Float(0.2) )
            let h = CGFloat( size * Float(0.7) )
            let shapeNode = SKShapeNode.init(rect: CGRect.init(x: 0, y: 0, width: w * sizeMultiplier, height: h * sizeMultiplier))
            shapeNode.fillColor = fillColor
            shapeNode.strokeColor = SKColor.clear
            shapeNode.position = CGPoint.init(x: -(w * sizeMultiplier)/2, y: -(h * sizeMultiplier)/2)
            self.addChild(shapeNode)
            
            //self.geometry = SCNBox.init(width: w, height: h, length: 0.002, chamferRadius: 0)
        }
        
        if (indicatorType == FaceIndicatorTypes.FaceIndicatorTypeFatBox) {
            let w = CGFloat( size * Float(0.25) )
            let h = CGFloat( size * Float(0.7) )
            let shapeNode = SKShapeNode.init(rect: CGRect.init(x: 0, y: 0, width: w * sizeMultiplier, height: h * sizeMultiplier))
            shapeNode.fillColor = fillColor
            shapeNode.strokeColor = SKColor.clear
            shapeNode.position = CGPoint.init(x: -(w * sizeMultiplier)/2, y: -(h * sizeMultiplier)/2)
            self.addChild(shapeNode)
            
            //self.geometry = SCNBox.init(width: w, height: h, length: 0.002, chamferRadius: 0)
        }
        
        if (indicatorType == FaceIndicatorTypes.FaceIndicatorTypeTube) {
            let w = CGFloat( size * Float(0.1) )
            let h = CGFloat( size * Float(0.6) )
            //let l = CGFloat( size * Float(0.1) )
            let cham = CGFloat( size * Float(0.05) )
            let shapeNode = SKShapeNode.init(rect: CGRect.init(x: 0, y: 0, width: w * sizeMultiplier, height: h * sizeMultiplier), cornerRadius: cham * sizeMultiplier)
            shapeNode.fillColor = fillColor
            shapeNode.strokeColor = SKColor.clear
            shapeNode.position = CGPoint.init(x: -(w * sizeMultiplier)/2, y: -(h * sizeMultiplier)/2)
            self.addChild(shapeNode)
            
            //self.geometry = SCNBox.init(width: w, height: h, length: l, chamferRadius: cham )
            //self.scale = SCNVector3Make( 1.0, 1.0, 0.3)
        }
        
        if (indicatorType == FaceIndicatorTypes.FaceIndicatorTypeSphere) {
            let r = CGFloat( size * Float(0.1) )
            let shapeNode = SKShapeNode.init(circleOfRadius: r * sizeMultiplier)
            shapeNode.fillColor = fillColor
            shapeNode.strokeColor = SKColor.clear
            self.addChild(shapeNode)
                
            //self.geometry = SCNSphere.init(radius: r)
            //self.scale = SCNVector3Make( 1.0, 1.0, 0.2)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
