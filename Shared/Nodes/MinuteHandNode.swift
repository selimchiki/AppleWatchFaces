//
//  MinuteHandNode.swift
//  SwissClock
//
//  Created by Mike Hill on 11/11/15.
//  Copyright © 2015 Mike Hill. All rights reserved.
//

import UIKit

import SpriteKit

enum MinuteHandTypes: String {
    case MinuteHandTypeSwiss, MinuteHandTypeRounded, MinuteHandTypeRoman, MinuteHandTypeBoxy, MinuteHandTypeFatBoxy, MinuteHandTypeSquaredHole, MinuteHandTypeSphere
    
    static let randomizableValues = [MinuteHandTypeSwiss, MinuteHandTypeRounded, MinuteHandTypeBoxy, MinuteHandTypeSquaredHole]
    static let userSelectableValues = [MinuteHandTypeSwiss, MinuteHandTypeRounded, MinuteHandTypeBoxy, MinuteHandTypeFatBoxy, MinuteHandTypeSquaredHole, MinuteHandTypeRoman, MinuteHandTypeSphere]
    
    static func random() -> MinuteHandTypes {
        let randomIndex = Int(arc4random_uniform(UInt32(randomizableValues.count)))
        return randomizableValues[randomIndex]
    }
}

enum MinuteHandMovements: String {
    case MinuteHandMovementStep, MinuteHandMovementSmooth
    
    static let randomizableValues = [MinuteHandMovementStep, MinuteHandMovementSmooth]
    static let userSelectableValues = randomizableValues
    
    static func random() -> MinuteHandMovements {
        let randomIndex = Int(arc4random_uniform(UInt32(randomizableValues.count)))
        return randomizableValues[randomIndex]
    }
}

class MinuteHandNode: SKSpriteNode {
    
    static func descriptionForType(_ nodeType: MinuteHandTypes) -> String {
        var typeDescription = ""
        
        if (nodeType == MinuteHandTypes.MinuteHandTypeSwiss)  { typeDescription = "Swiss" }
        if (nodeType == MinuteHandTypes.MinuteHandTypeRounded)  { typeDescription = "Rounded" }
        if (nodeType == MinuteHandTypes.MinuteHandTypeRoman)  { typeDescription = "Roman" }
        if (nodeType == MinuteHandTypes.MinuteHandTypeFatBoxy)  { typeDescription = "Fat Boxy" }
        if (nodeType == MinuteHandTypes.MinuteHandTypeBoxy)  { typeDescription = "Boxy" }
        if (nodeType == MinuteHandTypes.MinuteHandTypeSquaredHole)  { typeDescription = "Squared Hole" }
        if (nodeType == MinuteHandTypes.MinuteHandTypeSphere)  { typeDescription = "Magnetic Sphere" }
        
        return typeDescription
    }
    
    static func typeDescriptions() -> [String] {
        var typeDescriptionsArray = [String]()
        for nodeType in MinuteHandTypes.userSelectableValues {
            typeDescriptionsArray.append(descriptionForType(nodeType))
        }
        
        return typeDescriptionsArray
    }
    
    static func typeKeys() -> [String] {
        var typeKeysArray = [String]()
        for nodeType in MinuteHandTypes.userSelectableValues {
            typeKeysArray.append(nodeType.rawValue)
        }
        
        return typeKeysArray
    }
    
    convenience init(minuteHandType: MinuteHandTypes) {
        self.init(minuteHandType: minuteHandType, fillColor: SKColor.white)
    }
    
    init(minuteHandType: MinuteHandTypes, fillColor: SKColor) {
        
        super.init(texture: nil, color: fillColor, size: CGSize())
        self.name = "minuteHand"
        
        if (minuteHandType == MinuteHandTypes.MinuteHandTypeSphere) {
            
            let shape = SKShapeNode.init(circleOfRadius: 5)
            shape.position = CGPoint.init(x: 0, y: 70.0)
            
            shape.fillColor = fillColor
            shape.strokeColor = SKColor.clear
            
            self.addChild(shape)
        }
        
        if (minuteHandType == MinuteHandTypes.MinuteHandTypeFatBoxy) {
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: 3, y: 89))
            bezierPath.addCurve(to: CGPoint(x: 3, y: 6.33), controlPoint1: CGPoint(x: 3, y: 89), controlPoint2: CGPoint(x: 3, y: 35.9))
            bezierPath.addCurve(to: CGPoint(x: 7, y: 0), controlPoint1: CGPoint(x: 5.37, y: 5.2), controlPoint2: CGPoint(x: 7, y: 2.79))
            bezierPath.addCurve(to: CGPoint(x: 3, y: -6.33), controlPoint1: CGPoint(x: 7, y: -2.79), controlPoint2: CGPoint(x: 5.37, y: -5.2))
            bezierPath.addCurve(to: CGPoint(x: 3, y: -13), controlPoint1: CGPoint(x: 3, y: -10.52), controlPoint2: CGPoint(x: 3, y: -13))
            bezierPath.addLine(to: CGPoint(x: -3, y: -13))
            bezierPath.addCurve(to: CGPoint(x: -3, y: -6.33), controlPoint1: CGPoint(x: -3, y: -13), controlPoint2: CGPoint(x: -3, y: -10.52))
            bezierPath.addCurve(to: CGPoint(x: -7, y: 0), controlPoint1: CGPoint(x: -5.37, y: -5.2), controlPoint2: CGPoint(x: -7, y: -2.79))
            bezierPath.addCurve(to: CGPoint(x: -3, y: 6.33), controlPoint1: CGPoint(x: -7, y: 2.79), controlPoint2: CGPoint(x: -5.37, y: 5.2))
            bezierPath.addCurve(to: CGPoint(x: -3, y: 89), controlPoint1: CGPoint(x: -3, y: 35.9), controlPoint2: CGPoint(x: -3, y: 89))
            bezierPath.addLine(to: CGPoint(x: 3, y: 89))
            bezierPath.addLine(to: CGPoint(x: 3, y: 89))
            bezierPath.close()
            
            bezierPath.flatness = 0.1
            
            let shape = SKShapeNode.init(path: bezierPath.cgPath)
            shape.fillColor = fillColor
            shape.strokeColor = SKColor.clear
            
            self.addChild(shape)
        }
        
        if (minuteHandType == MinuteHandTypes.MinuteHandTypeSquaredHole) {

            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: 1.5, y: 83.7))
            bezierPath.addLine(to: CGPoint(x: -1.5, y: 83.7))
            bezierPath.addLine(to: CGPoint(x: -1.5, y: 74.02))
            bezierPath.addLine(to: CGPoint(x: 1.5, y: 74.02))
            bezierPath.addLine(to: CGPoint(x: 1.5, y: 83.7))
            bezierPath.close()
            bezierPath.move(to: CGPoint(x: 3, y: 88))
            bezierPath.addCurve(to: CGPoint(x: 3, y: -12), controlPoint1: CGPoint(x: 3, y: 88), controlPoint2: CGPoint(x: 3, y: -12))
            bezierPath.addLine(to: CGPoint(x: -3, y: -12))
            bezierPath.addLine(to: CGPoint(x: -3, y: 88))
            bezierPath.addLine(to: CGPoint(x: 3, y: 88))
            bezierPath.addLine(to: CGPoint(x: 3, y: 88))
            bezierPath.close()
            
            bezierPath.flatness = 0.1
            
            let shape = SKShapeNode.init(path: bezierPath.cgPath)
            shape.fillColor = fillColor
            shape.strokeColor = SKColor.clear
            
            self.addChild(shape)

        }
        
        if (minuteHandType == MinuteHandTypes.MinuteHandTypeBoxy) {
            
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: 1.5, y: 97))
            bezierPath.addCurve(to: CGPoint(x: 1.5, y: 4.77), controlPoint1: CGPoint(x: 1.5, y: 97), controlPoint2: CGPoint(x: 1.5, y: 35.9))
            bezierPath.addCurve(to: CGPoint(x: 5, y: 0), controlPoint1: CGPoint(x: 3.53, y: 4.13), controlPoint2: CGPoint(x: 5, y: 2.24))
            bezierPath.addCurve(to: CGPoint(x: 1.5, y: -4.77), controlPoint1: CGPoint(x: 5, y: -2.24), controlPoint2: CGPoint(x: 3.53, y: -4.13))
            bezierPath.addCurve(to: CGPoint(x: 1.5, y: -13), controlPoint1: CGPoint(x: 1.5, y: -9.91), controlPoint2: CGPoint(x: 1.5, y: -13))
            bezierPath.addLine(to: CGPoint(x: -1.5, y: -13))
            bezierPath.addCurve(to: CGPoint(x: -1.5, y: -4.77), controlPoint1: CGPoint(x: -1.5, y: -13), controlPoint2: CGPoint(x: -1.5, y: -9.91))
            bezierPath.addCurve(to: CGPoint(x: -5, y: 0), controlPoint1: CGPoint(x: -3.53, y: -4.13), controlPoint2: CGPoint(x: -5, y: -2.24))
            bezierPath.addCurve(to: CGPoint(x: -1.5, y: 4.77), controlPoint1: CGPoint(x: -5, y: 2.24), controlPoint2: CGPoint(x: -3.53, y: 4.13))
            bezierPath.addCurve(to: CGPoint(x: -1.5, y: 97), controlPoint1: CGPoint(x: -1.5, y: 35.9), controlPoint2: CGPoint(x: -1.5, y: 97))
            bezierPath.addLine(to: CGPoint(x: 1.5, y: 97))
            bezierPath.addLine(to: CGPoint(x: 1.5, y: 97))
            bezierPath.close()

            bezierPath.flatness = 0.1
            
            let shape = SKShapeNode.init(path: bezierPath.cgPath)
            shape.fillColor = fillColor
            shape.strokeColor = SKColor.clear
            
            self.addChild(shape)
        }
        
        if (minuteHandType == MinuteHandTypes.MinuteHandTypeSwiss) {
            
            let minuteHandPath = UIBezierPath()
            minuteHandPath.move(to: CGPoint(x: -4, y: -12))
            minuteHandPath.addLine(to: CGPoint(x: 4, y: -12))
            minuteHandPath.addLine(to: CGPoint(x: 2, y: 81))
            minuteHandPath.addLine(to: CGPoint(x: -2, y: 81))
            minuteHandPath.addLine(to: CGPoint(x: -4, y: -12))
            minuteHandPath.close()
            
            let shape = SKShapeNode.init(path: minuteHandPath.cgPath)
            shape.fillColor = fillColor
            shape.strokeColor = SKColor.clear
            
            self.addChild(shape)
        }
        
        if (minuteHandType == MinuteHandTypes.MinuteHandTypeRounded) {
        
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: 3, y: 79.5))
            bezierPath.addCurve(to: CGPoint(x: 3, y: 5.77), controlPoint1: CGPoint(x: 3, y: 79.5), controlPoint2: CGPoint(x: 3, y: 20.44))
            bezierPath.addCurve(to: CGPoint(x: 6.5, y: 0), controlPoint1: CGPoint(x: 5.08, y: 4.68), controlPoint2: CGPoint(x: 6.5, y: 2.51))
            bezierPath.addCurve(to: CGPoint(x: -0, y: -6.5), controlPoint1: CGPoint(x: 6.5, y: -3.59), controlPoint2: CGPoint(x: 3.59, y: -6.5))
            bezierPath.addCurve(to: CGPoint(x: -6.5, y: 0), controlPoint1: CGPoint(x: -3.59, y: -6.5), controlPoint2: CGPoint(x: -6.5, y: -3.59))
            bezierPath.addCurve(to: CGPoint(x: -3, y: 5.77), controlPoint1: CGPoint(x: -6.5, y: 2.51), controlPoint2: CGPoint(x: -5.08, y: 4.68))
            bezierPath.addCurve(to: CGPoint(x: -3, y: 79.5), controlPoint1: CGPoint(x: -3, y: 20.44), controlPoint2: CGPoint(x: -3, y: 79.5))
            bezierPath.addCurve(to: CGPoint(x: 0, y: 82.5), controlPoint1: CGPoint(x: -3, y: 81.16), controlPoint2: CGPoint(x: -1.66, y: 82.5))
            bezierPath.addCurve(to: CGPoint(x: 3, y: 79.5), controlPoint1: CGPoint(x: 1.66, y: 82.5), controlPoint2: CGPoint(x: 3, y: 81.16))
            bezierPath.close()

            bezierPath.flatness = 0.1
            
            let shape = SKShapeNode.init(path: bezierPath.cgPath)
            shape.fillColor = fillColor
            shape.strokeColor = SKColor.clear
            
            self.addChild(shape)
        }
        
        if (minuteHandType == MinuteHandTypes.MinuteHandTypeRoman) {
            
            let minuteHandPath = UIBezierPath()
            minuteHandPath.move(to: CGPoint(x: 0.83, y: 269.09))
            minuteHandPath.addCurve(to: CGPoint(x: 0.86, y: 268.86), controlPoint1: CGPoint(x: 0.85, y: 269.02), controlPoint2: CGPoint(x: 0.86, y: 268.94))
            minuteHandPath.addLine(to: CGPoint(x: 0.86, y: 258.11))
            minuteHandPath.addCurve(to: CGPoint(x: 3.16, y: 240.02), controlPoint1: CGPoint(x: 1.83, y: 254.25), controlPoint2: CGPoint(x: 3.16, y: 247.59))
            minuteHandPath.addCurve(to: CGPoint(x: 0.81, y: 221.7), controlPoint1: CGPoint(x: 3.16, y: 232.29), controlPoint2: CGPoint(x: 1.78, y: 225.52))
            minuteHandPath.addCurve(to: CGPoint(x: 4.27, y: 222.74), controlPoint1: CGPoint(x: 2.06, y: 222.25), controlPoint2: CGPoint(x: 3.41, y: 222.73))
            minuteHandPath.addCurve(to: CGPoint(x: 7.87, y: 220.17), controlPoint1: CGPoint(x: 6.26, y: 222.74), controlPoint2: CGPoint(x: 7.86, y: 221.59))
            minuteHandPath.addCurve(to: CGPoint(x: 4.27, y: 217.6), controlPoint1: CGPoint(x: 7.87, y: 218.75), controlPoint2: CGPoint(x: 6.26, y: 217.6))
            minuteHandPath.addCurve(to: CGPoint(x: 1.31, y: 218.43), controlPoint1: CGPoint(x: 3.52, y: 217.6), controlPoint2: CGPoint(x: 2.41, y: 217.97))
            minuteHandPath.addCurve(to: CGPoint(x: 5.7, y: 214.86), controlPoint1: CGPoint(x: 2.45, y: 216.06), controlPoint2: CGPoint(x: 4.06, y: 213.33))
            minuteHandPath.addCurve(to: CGPoint(x: 10.21, y: 220.04), controlPoint1: CGPoint(x: 6.69, y: 215.7), controlPoint2: CGPoint(x: 9.26, y: 218))
            minuteHandPath.addCurve(to: CGPoint(x: 10.71, y: 224.3), controlPoint1: CGPoint(x: 11.37, y: 222.11), controlPoint2: CGPoint(x: 10.92, y: 223.92))
            minuteHandPath.addCurve(to: CGPoint(x: 15.17, y: 222.98), controlPoint1: CGPoint(x: 9.07, y: 225.7), controlPoint2: CGPoint(x: 15.82, y: 222.54))
            minuteHandPath.addCurve(to: CGPoint(x: 15.2, y: 222.95), controlPoint1: CGPoint(x: 15.19, y: 222.94), controlPoint2: CGPoint(x: 15.2, y: 222.95))
            minuteHandPath.addCurve(to: CGPoint(x: 13.06, y: 218.22), controlPoint1: CGPoint(x: 16.93, y: 222.76), controlPoint2: CGPoint(x: 16.67, y: 220.91))
            minuteHandPath.addCurve(to: CGPoint(x: 6.09, y: 213.76), controlPoint1: CGPoint(x: 11.21, y: 216.72), controlPoint2: CGPoint(x: 8.2, y: 214.94))
            minuteHandPath.addCurve(to: CGPoint(x: 8.99, y: 214.38), controlPoint1: CGPoint(x: 7.01, y: 214.11), controlPoint2: CGPoint(x: 7.99, y: 214.33))
            minuteHandPath.addCurve(to: CGPoint(x: 15.63, y: 212.19), controlPoint1: CGPoint(x: 11.3, y: 214.5), controlPoint2: CGPoint(x: 13.72, y: 213.77))
            minuteHandPath.addCurve(to: CGPoint(x: 19.16, y: 205.5), controlPoint1: CGPoint(x: 17.54, y: 210.62), controlPoint2: CGPoint(x: 18.91, y: 208.28))
            minuteHandPath.addLine(to: CGPoint(x: 19.19, y: 205.11))
            minuteHandPath.addLine(to: CGPoint(x: 19.19, y: 204.56))
            minuteHandPath.addCurve(to: CGPoint(x: 19.13, y: 203.54), controlPoint1: CGPoint(x: 19.19, y: 204.21), controlPoint2: CGPoint(x: 19.17, y: 203.88))
            minuteHandPath.addCurve(to: CGPoint(x: 18.7, y: 201.53), controlPoint1: CGPoint(x: 19.06, y: 202.87), controlPoint2: CGPoint(x: 18.92, y: 202.19))
            minuteHandPath.addCurve(to: CGPoint(x: 16.61, y: 197.95), controlPoint1: CGPoint(x: 18.27, y: 200.22), controlPoint2: CGPoint(x: 17.55, y: 198.99))
            minuteHandPath.addCurve(to: CGPoint(x: 13.18, y: 195.46), controlPoint1: CGPoint(x: 15.66, y: 196.9), controlPoint2: CGPoint(x: 14.49, y: 196.05))
            minuteHandPath.addCurve(to: CGPoint(x: 11.13, y: 194.81), controlPoint1: CGPoint(x: 12.53, y: 195.17), controlPoint2: CGPoint(x: 11.83, y: 194.96))
            minuteHandPath.addCurve(to: CGPoint(x: 10.07, y: 194.64), controlPoint1: CGPoint(x: 10.78, y: 194.73), controlPoint2: CGPoint(x: 10.43, y: 194.68))
            minuteHandPath.addLine(to: CGPoint(x: 9.53, y: 194.6))
            minuteHandPath.addLine(to: CGPoint(x: 8.92, y: 194.59))
            minuteHandPath.addCurve(to: CGPoint(x: 8.56, y: 194.6), controlPoint1: CGPoint(x: 8.92, y: 194.59), controlPoint2: CGPoint(x: 8.64, y: 194.6))
            minuteHandPath.addCurve(to: CGPoint(x: 7.94, y: 194.65), controlPoint1: CGPoint(x: 8.53, y: 194.6), controlPoint2: CGPoint(x: 7.94, y: 194.65))
            minuteHandPath.addCurve(to: CGPoint(x: 7.73, y: 194.68), controlPoint1: CGPoint(x: 7.87, y: 194.66), controlPoint2: CGPoint(x: 7.8, y: 194.67))
            minuteHandPath.addCurve(to: CGPoint(x: 8.54, y: 194.21), controlPoint1: CGPoint(x: 8.11, y: 194.46), controlPoint2: CGPoint(x: 8.33, y: 194.34))
            minuteHandPath.addCurve(to: CGPoint(x: 13.1, y: 191.16), controlPoint1: CGPoint(x: 10.18, y: 193.24), controlPoint2: CGPoint(x: 11.89, y: 192.14))
            minuteHandPath.addCurve(to: CGPoint(x: 15.18, y: 186.38), controlPoint1: CGPoint(x: 16.71, y: 188.47), controlPoint2: CGPoint(x: 16.92, y: 186.6))
            minuteHandPath.addCurve(to: CGPoint(x: 15.2, y: 186.42), controlPoint1: CGPoint(x: 15.21, y: 186.4), controlPoint2: CGPoint(x: 15.2, y: 186.42))
            minuteHandPath.addCurve(to: CGPoint(x: 10.78, y: 185.13), controlPoint1: CGPoint(x: 15.83, y: 186.82), controlPoint2: CGPoint(x: 9.15, y: 183.68))
            minuteHandPath.addCurve(to: CGPoint(x: 10.23, y: 189.43), controlPoint1: CGPoint(x: 10.99, y: 185.53), controlPoint2: CGPoint(x: 11.42, y: 187.36))
            minuteHandPath.addCurve(to: CGPoint(x: 8.44, y: 191.94), controlPoint1: CGPoint(x: 9.83, y: 190.27), controlPoint2: CGPoint(x: 9.16, y: 191.14))
            minuteHandPath.addCurve(to: CGPoint(x: 5.64, y: 194.61), controlPoint1: CGPoint(x: 7.4, y: 193.1), controlPoint2: CGPoint(x: 6.24, y: 194.11))
            minuteHandPath.addCurve(to: CGPoint(x: 1.31, y: 191.01), controlPoint1: CGPoint(x: 4.01, y: 196.12), controlPoint2: CGPoint(x: 2.44, y: 193.39))
            minuteHandPath.addCurve(to: CGPoint(x: 4.18, y: 191.8), controlPoint1: CGPoint(x: 2.38, y: 191.45), controlPoint2: CGPoint(x: 3.45, y: 191.8))
            minuteHandPath.addCurve(to: CGPoint(x: 7.78, y: 189.23), controlPoint1: CGPoint(x: 6.17, y: 191.8), controlPoint2: CGPoint(x: 7.78, y: 190.65))
            minuteHandPath.addCurve(to: CGPoint(x: 4.19, y: 186.66), controlPoint1: CGPoint(x: 7.78, y: 187.81), controlPoint2: CGPoint(x: 6.17, y: 186.66))
            minuteHandPath.addCurve(to: CGPoint(x: 0.73, y: 187.7), controlPoint1: CGPoint(x: 3.32, y: 186.66), controlPoint2: CGPoint(x: 1.98, y: 187.15))
            minuteHandPath.addCurve(to: CGPoint(x: 3.09, y: 169.38), controlPoint1: CGPoint(x: 1.7, y: 183.88), controlPoint2: CGPoint(x: 3.08, y: 177.1))
            minuteHandPath.addCurve(to: CGPoint(x: 1.88, y: 135.21), controlPoint1: CGPoint(x: 3.09, y: 164.45), controlPoint2: CGPoint(x: 2.53, y: 150.22))
            minuteHandPath.addCurve(to: CGPoint(x: 2.34, y: 115.04), controlPoint1: CGPoint(x: 2.06, y: 128.48), controlPoint2: CGPoint(x: 2.21, y: 121.76))
            minuteHandPath.addLine(to: CGPoint(x: 2.62, y: 95.5))
            minuteHandPath.addLine(to: CGPoint(x: 2.77, y: 75.96))
            minuteHandPath.addCurve(to: CGPoint(x: 2.79, y: 61.96), controlPoint1: CGPoint(x: 2.77, y: 75.96), controlPoint2: CGPoint(x: 2.78, y: 67.73))
            minuteHandPath.addCurve(to: CGPoint(x: 2.8, y: 56.43), controlPoint1: CGPoint(x: 2.8, y: 58.83), controlPoint2: CGPoint(x: 2.8, y: 56.43))
            minuteHandPath.addLine(to: CGPoint(x: 2.75, y: 46.66))
            minuteHandPath.addCurve(to: CGPoint(x: 2.63, y: 36.89), controlPoint1: CGPoint(x: 2.74, y: 43.4), controlPoint2: CGPoint(x: 2.71, y: 40.15))
            minuteHandPath.addCurve(to: CGPoint(x: 1.05, y: -2.18), controlPoint1: CGPoint(x: 2.4, y: 23.87), controlPoint2: CGPoint(x: 2.01, y: 10.84))
            minuteHandPath.addCurve(to: CGPoint(x: 0.6, y: -3), controlPoint1: CGPoint(x: 1.03, y: -2.52), controlPoint2: CGPoint(x: 0.85, y: -2.81))
            minuteHandPath.addLine(to: CGPoint(x: -0.73, y: -3))
            minuteHandPath.addCurve(to: CGPoint(x: -1.18, y: -2.18), controlPoint1: CGPoint(x: -0.98, y: -2.81), controlPoint2: CGPoint(x: -1.15, y: -2.52))
            minuteHandPath.addCurve(to: CGPoint(x: -2.78, y: 36.89), controlPoint1: CGPoint(x: -2.14, y: 10.84), controlPoint2: CGPoint(x: -2.54, y: 23.86))
            minuteHandPath.addCurve(to: CGPoint(x: -2.91, y: 46.66), controlPoint1: CGPoint(x: -2.86, y: 40.15), controlPoint2: CGPoint(x: -2.89, y: 43.4))
            minuteHandPath.addLine(to: CGPoint(x: -2.96, y: 56.43))
            minuteHandPath.addLine(to: CGPoint(x: -2.94, y: 75.96))
            minuteHandPath.addLine(to: CGPoint(x: -2.8, y: 95.5))
            minuteHandPath.addLine(to: CGPoint(x: -2.53, y: 115.04))
            minuteHandPath.addCurve(to: CGPoint(x: -2.15, y: 132.44), controlPoint1: CGPoint(x: -2.43, y: 120.84), controlPoint2: CGPoint(x: -2.3, y: 126.64))
            minuteHandPath.addCurve(to: CGPoint(x: -3.5, y: 169.38), controlPoint1: CGPoint(x: -2.87, y: 148.44), controlPoint2: CGPoint(x: -3.5, y: 164.15))
            minuteHandPath.addCurve(to: CGPoint(x: -1.15, y: 187.7), controlPoint1: CGPoint(x: -3.5, y: 177.11), controlPoint2: CGPoint(x: -2.13, y: 183.88))
            minuteHandPath.addCurve(to: CGPoint(x: -4.61, y: 186.66), controlPoint1: CGPoint(x: -2.4, y: 187.15), controlPoint2: CGPoint(x: -3.75, y: 186.66))
            minuteHandPath.addCurve(to: CGPoint(x: -8.21, y: 189.23), controlPoint1: CGPoint(x: -6.6, y: 186.66), controlPoint2: CGPoint(x: -8.21, y: 187.81))
            minuteHandPath.addCurve(to: CGPoint(x: -4.61, y: 191.79), controlPoint1: CGPoint(x: -8.21, y: 190.64), controlPoint2: CGPoint(x: -6.6, y: 191.79))
            minuteHandPath.addCurve(to: CGPoint(x: -1.65, y: 190.97), controlPoint1: CGPoint(x: -3.86, y: 191.79), controlPoint2: CGPoint(x: -2.75, y: 191.43))
            minuteHandPath.addCurve(to: CGPoint(x: -6.04, y: 194.53), controlPoint1: CGPoint(x: -2.79, y: 193.34), controlPoint2: CGPoint(x: -4.4, y: 196.07))
            minuteHandPath.addCurve(to: CGPoint(x: -10.55, y: 189.36), controlPoint1: CGPoint(x: -7.03, y: 193.7), controlPoint2: CGPoint(x: -9.6, y: 191.4))
            minuteHandPath.addCurve(to: CGPoint(x: -11.05, y: 185.1), controlPoint1: CGPoint(x: -11.71, y: 187.29), controlPoint2: CGPoint(x: -11.26, y: 185.48))
            minuteHandPath.addCurve(to: CGPoint(x: -15.51, y: 186.42), controlPoint1: CGPoint(x: -9.42, y: 183.7), controlPoint2: CGPoint(x: -16.16, y: 186.86))
            minuteHandPath.addCurve(to: CGPoint(x: -15.54, y: 186.44), controlPoint1: CGPoint(x: -15.53, y: 186.46), controlPoint2: CGPoint(x: -15.54, y: 186.44))
            minuteHandPath.addCurve(to: CGPoint(x: -13.4, y: 191.18), controlPoint1: CGPoint(x: -17.27, y: 186.64), controlPoint2: CGPoint(x: -17.01, y: 188.49))
            minuteHandPath.addCurve(to: CGPoint(x: -7.35, y: 195.12), controlPoint1: CGPoint(x: -11.81, y: 192.47), controlPoint2: CGPoint(x: -9.35, y: 193.97))
            minuteHandPath.addCurve(to: CGPoint(x: -10.63, y: 194.58), controlPoint1: CGPoint(x: -8.41, y: 194.76), controlPoint2: CGPoint(x: -9.52, y: 194.57))
            minuteHandPath.addCurve(to: CGPoint(x: -18.14, y: 198.03), controlPoint1: CGPoint(x: -13.5, y: 194.57), controlPoint2: CGPoint(x: -16.35, y: 195.9))
            minuteHandPath.addCurve(to: CGPoint(x: -20.66, y: 205.54), controlPoint1: CGPoint(x: -19.98, y: 200.13), controlPoint2: CGPoint(x: -20.88, y: 202.93))
            minuteHandPath.addCurve(to: CGPoint(x: -20.61, y: 205.99), controlPoint1: CGPoint(x: -20.66, y: 205.6), controlPoint2: CGPoint(x: -20.61, y: 205.99))
            minuteHandPath.addCurve(to: CGPoint(x: -20.53, y: 206.51), controlPoint1: CGPoint(x: -20.58, y: 206.15), controlPoint2: CGPoint(x: -20.56, y: 206.34))
            minuteHandPath.addCurve(to: CGPoint(x: -20.28, y: 207.46), controlPoint1: CGPoint(x: -20.46, y: 206.84), controlPoint2: CGPoint(x: -20.38, y: 207.15))
            minuteHandPath.addCurve(to: CGPoint(x: -19.46, y: 209.2), controlPoint1: CGPoint(x: -20.08, y: 208.08), controlPoint2: CGPoint(x: -19.8, y: 208.66))
            minuteHandPath.addCurve(to: CGPoint(x: -16.95, y: 211.86), controlPoint1: CGPoint(x: -18.78, y: 210.28), controlPoint2: CGPoint(x: -17.89, y: 211.16))
            minuteHandPath.addCurve(to: CGPoint(x: -13.96, y: 213.59), controlPoint1: CGPoint(x: -16, y: 212.56), controlPoint2: CGPoint(x: -15.01, y: 213.14))
            minuteHandPath.addCurve(to: CGPoint(x: -10.63, y: 214.38), controlPoint1: CGPoint(x: -12.92, y: 214.05), controlPoint2: CGPoint(x: -11.79, y: 214.31))
            minuteHandPath.addCurve(to: CGPoint(x: -4, y: 212.18), controlPoint1: CGPoint(x: -8.33, y: 214.5), controlPoint2: CGPoint(x: -5.9, y: 213.76))
            minuteHandPath.addCurve(to: CGPoint(x: -0.75, y: 207.08), controlPoint1: CGPoint(x: -2.46, y: 210.94), controlPoint2: CGPoint(x: -1.29, y: 209.13))
            minuteHandPath.addCurve(to: CGPoint(x: -0.65, y: 207.47), controlPoint1: CGPoint(x: -0.72, y: 207.21), controlPoint2: CGPoint(x: -0.69, y: 207.34))
            minuteHandPath.addCurve(to: CGPoint(x: 0.17, y: 209.21), controlPoint1: CGPoint(x: -0.45, y: 208.09), controlPoint2: CGPoint(x: -0.17, y: 208.67))
            minuteHandPath.addCurve(to: CGPoint(x: 2.68, y: 211.87), controlPoint1: CGPoint(x: 0.85, y: 210.29), controlPoint2: CGPoint(x: 1.74, y: 211.16))
            minuteHandPath.addCurve(to: CGPoint(x: 3.61, y: 212.48), controlPoint1: CGPoint(x: 2.98, y: 212.09), controlPoint2: CGPoint(x: 3.3, y: 212.28))
            minuteHandPath.addCurve(to: CGPoint(x: 0.06, y: 218.98), controlPoint1: CGPoint(x: 2.4, y: 212.12), controlPoint2: CGPoint(x: 0.82, y: 216.14))
            minuteHandPath.addCurve(to: CGPoint(x: -0.13, y: 218.4), controlPoint1: CGPoint(x: -0.06, y: 218.61), controlPoint2: CGPoint(x: -0.13, y: 218.4))
            minuteHandPath.addCurve(to: CGPoint(x: -0.31, y: 218.98), controlPoint1: CGPoint(x: -0.13, y: 218.4), controlPoint2: CGPoint(x: -0.2, y: 218.61))
            minuteHandPath.addLine(to: CGPoint(x: -0.42, y: 218.93))
            minuteHandPath.addCurve(to: CGPoint(x: -4, y: 212.52), controlPoint1: CGPoint(x: -1.2, y: 216.02), controlPoint2: CGPoint(x: -2.76, y: 211.91))
            minuteHandPath.addCurve(to: CGPoint(x: -13.44, y: 218.24), controlPoint1: CGPoint(x: -3.77, y: 212.35), controlPoint2: CGPoint(x: -10.31, y: 215.7))
            minuteHandPath.addCurve(to: CGPoint(x: -15.52, y: 223.02), controlPoint1: CGPoint(x: -17.05, y: 220.92), controlPoint2: CGPoint(x: -17.26, y: 222.8))
            minuteHandPath.addCurve(to: CGPoint(x: -15.54, y: 222.98), controlPoint1: CGPoint(x: -15.55, y: 222.99), controlPoint2: CGPoint(x: -15.54, y: 222.98))
            minuteHandPath.addCurve(to: CGPoint(x: -11.12, y: 224.27), controlPoint1: CGPoint(x: -16.17, y: 222.58), controlPoint2: CGPoint(x: -9.49, y: 225.72))
            minuteHandPath.addCurve(to: CGPoint(x: -10.57, y: 219.96), controlPoint1: CGPoint(x: -11.33, y: 223.86), controlPoint2: CGPoint(x: -11.76, y: 222.03))
            minuteHandPath.addCurve(to: CGPoint(x: -5.98, y: 214.79), controlPoint1: CGPoint(x: -9.59, y: 217.91), controlPoint2: CGPoint(x: -6.99, y: 215.62))
            minuteHandPath.addCurve(to: CGPoint(x: -1.65, y: 218.39), controlPoint1: CGPoint(x: -4.36, y: 213.28), controlPoint2: CGPoint(x: -2.78, y: 216.01))
            minuteHandPath.addCurve(to: CGPoint(x: -4.53, y: 217.6), controlPoint1: CGPoint(x: -2.72, y: 217.95), controlPoint2: CGPoint(x: -3.79, y: 217.6))
            minuteHandPath.addCurve(to: CGPoint(x: -8.12, y: 220.16), controlPoint1: CGPoint(x: -6.51, y: 217.6), controlPoint2: CGPoint(x: -8.12, y: 218.75))
            minuteHandPath.addCurve(to: CGPoint(x: -4.53, y: 222.73), controlPoint1: CGPoint(x: -8.12, y: 221.58), controlPoint2: CGPoint(x: -6.51, y: 222.73))
            minuteHandPath.addCurve(to: CGPoint(x: -1.07, y: 221.7), controlPoint1: CGPoint(x: -3.66, y: 222.73), controlPoint2: CGPoint(x: -2.32, y: 222.25))
            minuteHandPath.addCurve(to: CGPoint(x: -3.43, y: 240.02), controlPoint1: CGPoint(x: -2.04, y: 225.52), controlPoint2: CGPoint(x: -3.42, y: 232.3))
            minuteHandPath.addCurve(to: CGPoint(x: -1.14, y: 258.11), controlPoint1: CGPoint(x: -3.43, y: 247.6), controlPoint2: CGPoint(x: -2.11, y: 254.25))
            minuteHandPath.addLine(to: CGPoint(x: -1.14, y: 268.86))
            minuteHandPath.addCurve(to: CGPoint(x: -0.14, y: 269.86), controlPoint1: CGPoint(x: -1.14, y: 269.41), controlPoint2: CGPoint(x: -0.69, y: 269.86))
            minuteHandPath.addCurve(to: CGPoint(x: 0.83, y: 269.09), controlPoint1: CGPoint(x: 0.33, y: 269.86), controlPoint2: CGPoint(x: 0.73, y: 269.53))
            minuteHandPath.close()
            minuteHandPath.move(to: CGPoint(x: 6.3, y: 212.07))
            minuteHandPath.addCurve(to: CGPoint(x: 4.17, y: 210.38), controlPoint1: CGPoint(x: 5.44, y: 211.73), controlPoint2: CGPoint(x: 4.68, y: 211.13))
            minuteHandPath.addCurve(to: CGPoint(x: 3.26, y: 207.93), controlPoint1: CGPoint(x: 3.65, y: 209.62), controlPoint2: CGPoint(x: 3.38, y: 208.75))
            minuteHandPath.addCurve(to: CGPoint(x: 3.19, y: 206.71), controlPoint1: CGPoint(x: 3.21, y: 207.51), controlPoint2: CGPoint(x: 3.19, y: 207.1))
            minuteHandPath.addCurve(to: CGPoint(x: 3.21, y: 206.13), controlPoint1: CGPoint(x: 3.2, y: 206.51), controlPoint2: CGPoint(x: 3.2, y: 206.31))
            minuteHandPath.addCurve(to: CGPoint(x: 3.24, y: 205.89), controlPoint1: CGPoint(x: 3.23, y: 206.05), controlPoint2: CGPoint(x: 3.23, y: 205.98))
            minuteHandPath.addCurve(to: CGPoint(x: 3.26, y: 205.55), controlPoint1: CGPoint(x: 3.24, y: 205.89), controlPoint2: CGPoint(x: 3.25, y: 205.66))
            minuteHandPath.addLine(to: CGPoint(x: 3.27, y: 205.5))
            minuteHandPath.addCurve(to: CGPoint(x: 5.37, y: 201.93), controlPoint1: CGPoint(x: 3.48, y: 204.01), controlPoint2: CGPoint(x: 4.29, y: 202.73))
            minuteHandPath.addCurve(to: CGPoint(x: 7.13, y: 201.04), controlPoint1: CGPoint(x: 5.92, y: 201.53), controlPoint2: CGPoint(x: 6.52, y: 201.22))
            minuteHandPath.addCurve(to: CGPoint(x: 8.05, y: 200.83), controlPoint1: CGPoint(x: 7.43, y: 200.94), controlPoint2: CGPoint(x: 7.74, y: 200.87))
            minuteHandPath.addLine(to: CGPoint(x: 8.52, y: 200.78))
            minuteHandPath.addLine(to: CGPoint(x: 8.69, y: 200.77))
            minuteHandPath.addCurve(to: CGPoint(x: 8.83, y: 200.77), controlPoint1: CGPoint(x: 8.69, y: 200.77), controlPoint2: CGPoint(x: 8.76, y: 200.77))
            minuteHandPath.addCurve(to: CGPoint(x: 9, y: 200.76), controlPoint1: CGPoint(x: 8.91, y: 200.76), controlPoint2: CGPoint(x: 9, y: 200.76))
            minuteHandPath.addCurve(to: CGPoint(x: 9.24, y: 200.77), controlPoint1: CGPoint(x: 9.12, y: 200.77), controlPoint2: CGPoint(x: 9.24, y: 200.77))
            minuteHandPath.addLine(to: CGPoint(x: 9.47, y: 200.79))
            minuteHandPath.addCurve(to: CGPoint(x: 9.94, y: 200.85), controlPoint1: CGPoint(x: 9.63, y: 200.81), controlPoint2: CGPoint(x: 9.78, y: 200.82))
            minuteHandPath.addCurve(to: CGPoint(x: 10.85, y: 201.09), controlPoint1: CGPoint(x: 10.25, y: 200.9), controlPoint2: CGPoint(x: 10.55, y: 200.99))
            minuteHandPath.addCurve(to: CGPoint(x: 12.53, y: 202.03), controlPoint1: CGPoint(x: 11.44, y: 201.29), controlPoint2: CGPoint(x: 12.01, y: 201.61))
            minuteHandPath.addCurve(to: CGPoint(x: 13.85, y: 203.55), controlPoint1: CGPoint(x: 13.04, y: 202.44), controlPoint2: CGPoint(x: 13.49, y: 202.95))
            minuteHandPath.addCurve(to: CGPoint(x: 14.31, y: 204.5), controlPoint1: CGPoint(x: 14.03, y: 203.84), controlPoint2: CGPoint(x: 14.19, y: 204.16))
            minuteHandPath.addCurve(to: CGPoint(x: 14.47, y: 205.01), controlPoint1: CGPoint(x: 14.37, y: 204.66), controlPoint2: CGPoint(x: 14.43, y: 204.84))
            minuteHandPath.addLine(to: CGPoint(x: 14.54, y: 205.23))
            minuteHandPath.addCurve(to: CGPoint(x: 14.59, y: 205.57), controlPoint1: CGPoint(x: 14.54, y: 205.23), controlPoint2: CGPoint(x: 14.57, y: 205.46))
            minuteHandPath.addCurve(to: CGPoint(x: 14.63, y: 205.83), controlPoint1: CGPoint(x: 14.61, y: 205.7), controlPoint2: CGPoint(x: 14.63, y: 205.83))
            minuteHandPath.addLine(to: CGPoint(x: 14.66, y: 206.12))
            minuteHandPath.addCurve(to: CGPoint(x: 14.68, y: 206.69), controlPoint1: CGPoint(x: 14.67, y: 206.3), controlPoint2: CGPoint(x: 14.68, y: 206.5))
            minuteHandPath.addCurve(to: CGPoint(x: 14.53, y: 207.85), controlPoint1: CGPoint(x: 14.67, y: 207.07), controlPoint2: CGPoint(x: 14.62, y: 207.46))
            minuteHandPath.addCurve(to: CGPoint(x: 13.5, y: 210.06), controlPoint1: CGPoint(x: 14.35, y: 208.62), controlPoint2: CGPoint(x: 14.01, y: 209.39))
            minuteHandPath.addCurve(to: CGPoint(x: 8.99, y: 212.48), controlPoint1: CGPoint(x: 12.5, y: 211.42), controlPoint2: CGPoint(x: 10.82, y: 212.38))
            minuteHandPath.addCurve(to: CGPoint(x: 6.3, y: 212.07), controlPoint1: CGPoint(x: 8.08, y: 212.54), controlPoint2: CGPoint(x: 7.16, y: 212.4))
            minuteHandPath.close()
            minuteHandPath.move(to: CGPoint(x: -13.33, y: 212.06))
            minuteHandPath.addCurve(to: CGPoint(x: -15.46, y: 210.37), controlPoint1: CGPoint(x: -14.19, y: 211.73), controlPoint2: CGPoint(x: -14.95, y: 211.13))
            minuteHandPath.addCurve(to: CGPoint(x: -16.36, y: 207.92), controlPoint1: CGPoint(x: -15.97, y: 209.62), controlPoint2: CGPoint(x: -16.25, y: 208.75))
            minuteHandPath.addCurve(to: CGPoint(x: -16.44, y: 206.71), controlPoint1: CGPoint(x: -16.42, y: 207.5), controlPoint2: CGPoint(x: -16.44, y: 207.1))
            minuteHandPath.addCurve(to: CGPoint(x: -16.41, y: 206.12), controlPoint1: CGPoint(x: -16.43, y: 206.51), controlPoint2: CGPoint(x: -16.43, y: 206.31))
            minuteHandPath.addCurve(to: CGPoint(x: -16.39, y: 205.88), controlPoint1: CGPoint(x: -16.4, y: 206.04), controlPoint2: CGPoint(x: -16.4, y: 205.97))
            minuteHandPath.addCurve(to: CGPoint(x: -16.37, y: 205.55), controlPoint1: CGPoint(x: -16.39, y: 205.88), controlPoint2: CGPoint(x: -16.37, y: 205.65))
            minuteHandPath.addLine(to: CGPoint(x: -16.35, y: 205.49))
            minuteHandPath.addCurve(to: CGPoint(x: -14.26, y: 201.92), controlPoint1: CGPoint(x: -16.14, y: 204), controlPoint2: CGPoint(x: -15.34, y: 202.73))
            minuteHandPath.addCurve(to: CGPoint(x: -10.63, y: 200.76), controlPoint1: CGPoint(x: -13.14, y: 201.12), controlPoint2: CGPoint(x: -11.89, y: 200.75))
            minuteHandPath.addCurve(to: CGPoint(x: -7.1, y: 202.02), controlPoint1: CGPoint(x: -9.37, y: 200.77), controlPoint2: CGPoint(x: -8.14, y: 201.19))
            minuteHandPath.addCurve(to: CGPoint(x: -5.04, y: 205.55), controlPoint1: CGPoint(x: -6.08, y: 202.85), controlPoint2: CGPoint(x: -5.28, y: 204.07))
            minuteHandPath.addCurve(to: CGPoint(x: -6.13, y: 210.06), controlPoint1: CGPoint(x: -4.77, y: 207.02), controlPoint2: CGPoint(x: -5.1, y: 208.7))
            minuteHandPath.addCurve(to: CGPoint(x: -10.63, y: 212.48), controlPoint1: CGPoint(x: -7.13, y: 211.41), controlPoint2: CGPoint(x: -8.8, y: 212.37))
            minuteHandPath.addCurve(to: CGPoint(x: -13.33, y: 212.06), controlPoint1: CGPoint(x: -11.54, y: 212.54), controlPoint2: CGPoint(x: -12.47, y: 212.39))
            minuteHandPath.close()
            minuteHandPath.move(to: CGPoint(x: -0.73, y: 202.26))
            minuteHandPath.addCurve(to: CGPoint(x: -0.93, y: 201.53), controlPoint1: CGPoint(x: -0.79, y: 202.01), controlPoint2: CGPoint(x: -0.85, y: 201.77))
            minuteHandPath.addCurve(to: CGPoint(x: -3.02, y: 197.94), controlPoint1: CGPoint(x: -1.36, y: 200.22), controlPoint2: CGPoint(x: -2.07, y: 198.99))
            minuteHandPath.addCurve(to: CGPoint(x: -4.07, y: 196.94), controlPoint1: CGPoint(x: -3.34, y: 197.58), controlPoint2: CGPoint(x: -3.7, y: 197.25))
            minuteHandPath.addCurve(to: CGPoint(x: -4.04, y: 196.9), controlPoint1: CGPoint(x: -4.08, y: 196.89), controlPoint2: CGPoint(x: -4.01, y: 196.92))
            minuteHandPath.addCurve(to: CGPoint(x: -0.4, y: 190.42), controlPoint1: CGPoint(x: -2.82, y: 197.5), controlPoint2: CGPoint(x: -1.18, y: 193.33))
            minuteHandPath.addCurve(to: CGPoint(x: -0.21, y: 191), controlPoint1: CGPoint(x: -0.29, y: 190.78), controlPoint2: CGPoint(x: -0.21, y: 191))
            minuteHandPath.addCurve(to: CGPoint(x: -0.03, y: 190.41), controlPoint1: CGPoint(x: -0.21, y: 191), controlPoint2: CGPoint(x: -0.15, y: 190.79))
            minuteHandPath.addCurve(to: CGPoint(x: 0.08, y: 190.47), controlPoint1: CGPoint(x: 0.01, y: 190.43), controlPoint2: CGPoint(x: 0.05, y: 190.45))
            minuteHandPath.addCurve(to: CGPoint(x: 2.89, y: 196.71), controlPoint1: CGPoint(x: 0.7, y: 192.8), controlPoint2: CGPoint(x: 1.83, y: 195.88))
            minuteHandPath.addCurve(to: CGPoint(x: 1.48, y: 198.04), controlPoint1: CGPoint(x: 2.38, y: 197.11), controlPoint2: CGPoint(x: 1.9, y: 197.55))
            minuteHandPath.addCurve(to: CGPoint(x: -0.73, y: 202.26), controlPoint1: CGPoint(x: 0.41, y: 199.26), controlPoint2: CGPoint(x: -0.33, y: 200.73))
            minuteHandPath.close()

            minuteHandPath.flatness = 0.05
            
            let shape = SKShapeNode.init(path: minuteHandPath.cgPath)
            shape.setScale(0.35)
            shape.fillColor = fillColor
            shape.strokeColor = SKColor.clear
            
            self.addChild(shape)
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
