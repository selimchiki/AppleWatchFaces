//
//  FaceBackgroundNode.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/17/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import SpriteKit
import SceneKit

enum FaceBackgroundTypes: String {
    case FaceBackgroundTypeFilled, FaceBackgroundTypeCircle, FaceBackgroundTypeDiagonalSplit, FaceBackgroundTypeVerticalSplit, FaceBackgroundTypeHorizontalSplit, FaceBackgroundTypeNone
    
    static let randomizableValues = [FaceBackgroundTypeCircle, FaceBackgroundTypeFilled, FaceBackgroundTypeDiagonalSplit,
        FaceBackgroundTypeVerticalSplit, FaceBackgroundTypeHorizontalSplit, FaceBackgroundTypeNone]
    static let userSelectableValues = [FaceBackgroundTypeFilled, FaceBackgroundTypeCircle, FaceBackgroundTypeDiagonalSplit,
        FaceBackgroundTypeVerticalSplit, FaceBackgroundTypeHorizontalSplit, FaceBackgroundTypeNone]
    
    static func random() -> FaceBackgroundTypes {
        let randomIndex = Int(arc4random_uniform(UInt32(randomizableValues.count)))
        return randomizableValues[randomIndex]
    }
}

class FaceBackgroundNode: SKSpriteNode {
    
    static func descriptionForType(_ nodeType: FaceBackgroundTypes) -> String {
        var typeDescription = ""
        
        if (nodeType == FaceBackgroundTypes.FaceBackgroundTypeCircle)  { typeDescription = "Circle" }
        if (nodeType == FaceBackgroundTypes.FaceBackgroundTypeFilled)  { typeDescription = "Filled" }
        if (nodeType == FaceBackgroundTypes.FaceBackgroundTypeDiagonalSplit)  { typeDescription = "Split Diagonal" }
        if (nodeType == FaceBackgroundTypes.FaceBackgroundTypeVerticalSplit)  { typeDescription = "Vertical Split" }
        if (nodeType == FaceBackgroundTypes.FaceBackgroundTypeHorizontalSplit)  { typeDescription = "Horizonatal Split" }
        if (nodeType == FaceBackgroundTypes.FaceBackgroundTypeNone)  { typeDescription = "None" }
        
        return typeDescription
    }
    
    static func typeDescriptions() -> [String] {
        var typeDescriptionsArray = [String]()
        for nodeType in FaceBackgroundTypes.userSelectableValues {
            typeDescriptionsArray.append(descriptionForType(nodeType))
        }
        
        return typeDescriptionsArray
    }
    
    static func typeKeys() -> [String] {
        var typeKeysArray = [String]()
        for nodeType in FaceBackgroundTypes.userSelectableValues {
            typeKeysArray.append(nodeType.rawValue)
        }
        
        return typeKeysArray
    }
    
    init(backgroundType: FaceBackgroundTypes, material: String) {
        
        super.init(texture: nil, color: SKColor.clear, size: CGSize.init())
        
        self.name = "FaceBackground"
        let sizeMultiplier = CGFloat(SKWatchScene.sizeMulitplier)
        
        if (backgroundType == FaceBackgroundTypes.FaceBackgroundTypeDiagonalSplit) {
            let boundsPosition = 1.5 * sizeMultiplier
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: boundsPosition, y: boundsPosition))
            bezierPath.addLine(to: CGPoint(x: -boundsPosition, y: -boundsPosition))
            bezierPath.addLine(to: CGPoint(x: boundsPosition, y: -boundsPosition))
            bezierPath.close()
            
            let shapeNode = SKShapeNode.init(path: bezierPath.cgPath)
            shapeNode.setMaterial(material: material)
            
            self.addChild(shapeNode)
        }
        
        if (backgroundType == FaceBackgroundTypes.FaceBackgroundTypeVerticalSplit) {
            let boundsPosition = 1.5 * sizeMultiplier
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: 0, y: boundsPosition))
            bezierPath.addLine(to: CGPoint(x: boundsPosition, y: boundsPosition))
            bezierPath.addLine(to: CGPoint(x: boundsPosition, y: -boundsPosition))
            bezierPath.addLine(to: CGPoint(x: 0, y: -boundsPosition))
            bezierPath.close()
            
            let shapeNode = SKShapeNode.init(path: bezierPath.cgPath)
            shapeNode.setMaterial(material: material)
            
            self.addChild(shapeNode)
        }
        
        if (backgroundType == FaceBackgroundTypes.FaceBackgroundTypeHorizontalSplit) {
            let boundsPosition = 1.5 * sizeMultiplier
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: boundsPosition, y: 0))
            bezierPath.addLine(to: CGPoint(x: boundsPosition, y: -boundsPosition))
            bezierPath.addLine(to: CGPoint(x: -boundsPosition, y: -boundsPosition))
            bezierPath.addLine(to: CGPoint(x: -boundsPosition, y: 0))
            bezierPath.close()
            
            let shapeNode = SKShapeNode.init(path: bezierPath.cgPath)
            shapeNode.setMaterial(material: material)
            
            self.addChild(shapeNode)
        }
        
        if (backgroundType == FaceBackgroundTypes.FaceBackgroundTypeFilled) {
            let w = CGFloat( CGFloat(4.0) )
            let h = CGFloat( CGFloat(4.0) )
            let shapeNode = SKShapeNode.init(rect: CGRect.init(x: 0, y: 0, width: w * sizeMultiplier, height: h * sizeMultiplier))
            shapeNode.setMaterial(material: material)
            shapeNode.position = CGPoint.init(x: -(w * sizeMultiplier)/2, y: -(h * sizeMultiplier)/2)
            self.addChild(shapeNode)
        }
        
        if (backgroundType == FaceBackgroundTypes.FaceBackgroundTypeCircle) {
            let r = CGFloat(1.04)
            let shapeNode = SKShapeNode.init(circleOfRadius: r * sizeMultiplier)
            shapeNode.setMaterial(material: material)
            
            self.addChild(shapeNode)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
