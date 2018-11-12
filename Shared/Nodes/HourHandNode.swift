//
//  MinuteHandNode.swift
//  SwissClock
//
//  Created by Mike Hill on 11/11/15.
//  Copyright © 2015 Mike Hill. All rights reserved.
//

import SpriteKit

enum HourHandTypes: String {
    case HourHandTypeSwiss, HourHandTypeRounded, HourHandTypeRoman, HourHandTypeBoxy, HourHandTypeSquaredHole, HourHandTypeSphere,
        HourHandTypeCutout
    
    static let randomizableValues = [HourHandTypeSwiss, HourHandTypeRounded, HourHandTypeBoxy, HourHandTypeSquaredHole]
    static let userSelectableValues = [HourHandTypeSwiss, HourHandTypeRounded, HourHandTypeBoxy, HourHandTypeSquaredHole, HourHandTypeRoman, HourHandTypeSphere, HourHandTypeCutout]
    
    static func random() -> HourHandTypes {
        let randomIndex = Int(arc4random_uniform(UInt32(randomizableValues.count)))
        return randomizableValues[randomIndex]
    }
}

class HourHandNode: SKSpriteNode {
    
    static func descriptionForType(_ nodeType: HourHandTypes) -> String {
        var typeDescription = ""
        
        if (nodeType == HourHandTypes.HourHandTypeSwiss)  { typeDescription = "Swiss" }
        if (nodeType == HourHandTypes.HourHandTypeRounded)  { typeDescription = "Rounded" }
        if (nodeType == HourHandTypes.HourHandTypeRoman)  { typeDescription = "Roman" }
        if (nodeType == HourHandTypes.HourHandTypeSphere)  { typeDescription = "Magnetic Sphere" }
        if (nodeType == HourHandTypes.HourHandTypeBoxy)  { typeDescription = "Boxy" }
        if (nodeType == HourHandTypes.HourHandTypeSquaredHole)  { typeDescription = "Squared Hole" }
        if (nodeType == HourHandTypes.HourHandTypeCutout)  { typeDescription = "Square Cutout" }

        return typeDescription
    }
    
    static func typeDescriptions() -> [String] {
        var typeDescriptionsArray = [String]()
        for nodeType in HourHandTypes.userSelectableValues {
            typeDescriptionsArray.append(descriptionForType(nodeType))
        }
        
        return typeDescriptionsArray
    }
    
    static func typeKeys() -> [String] {
        var typeKeysArray = [String]()
        for nodeType in HourHandTypes.userSelectableValues {
            typeKeysArray.append(nodeType.rawValue)
        }
        
        return typeKeysArray
    }
    
    convenience init(hourHandType: HourHandTypes) {
        self.init(hourHandType: hourHandType, fillColor: SKColor.white)
    }
    
    convenience init(hourHandType: HourHandTypes, fillColor: SKColor) {
        self.init(hourHandType: hourHandType, fillColor: SKColor.red, strokeColor: SKColor.clear, lineWidth: 2.0)
    }
    
    init(hourHandType: HourHandTypes, fillColor: SKColor, strokeColor: SKColor, lineWidth: CGFloat) {

        super.init(texture: nil, color: fillColor, size: CGSize())
        
        self.name = "hourHand"
        
        if (hourHandType == HourHandTypes.HourHandTypeSphere) {
            
            let shape = SKShapeNode.init(circleOfRadius: 5)
            shape.position = CGPoint.init(x: 0, y: 53.0)
            
            shape.fillColor = fillColor
            shape.strokeColor = strokeColor
            shape.lineWidth = lineWidth
            
            self.addChild(shape)
        }
        
        if (hourHandType == HourHandTypes.HourHandTypeCutout) {
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: 7, y: 56))
            bezierPath.addLine(to: CGPoint(x: -7, y: 56))
            bezierPath.addLine(to: CGPoint(x: -7, y: 0))
            bezierPath.addLine(to: CGPoint(x: 7, y: 0))
            bezierPath.addLine(to: CGPoint(x: 7, y: 56))
            bezierPath.close()
            bezierPath.move(to: CGPoint(x: 100, y: -0))
            bezierPath.addCurve(to: CGPoint(x: -0, y: -100), controlPoint1: CGPoint(x: 100, y: -55.23), controlPoint2: CGPoint(x: 55.23, y: -100))
            bezierPath.addCurve(to: CGPoint(x: -100, y: 0), controlPoint1: CGPoint(x: -55.23, y: -100), controlPoint2: CGPoint(x: -100, y: -55.23))
            bezierPath.addCurve(to: CGPoint(x: 0, y: 100), controlPoint1: CGPoint(x: -100, y: 55.23), controlPoint2: CGPoint(x: -55.23, y: 100))
            bezierPath.addCurve(to: CGPoint(x: 100, y: -0), controlPoint1: CGPoint(x: 55.23, y: 100), controlPoint2: CGPoint(x: 100, y: 55.23))
            bezierPath.close()
            
            bezierPath.flatness = 0.01
            
            let shape = SKShapeNode.init(path: bezierPath.cgPath)
            shape.fillColor = fillColor
            shape.strokeColor = strokeColor
            shape.lineWidth = lineWidth
            
            self.addChild(shape)
        }

        
        if (hourHandType == HourHandTypes.HourHandTypeBoxy) {

            let rectanglePath = UIBezierPath(rect: CGRect(x: -1.5, y: -11, width: 3, height: 60))
            
            let shape = SKShapeNode.init(path: rectanglePath.cgPath)
            shape.fillColor = fillColor
            shape.strokeColor = strokeColor
            shape.lineWidth = lineWidth
            
            self.addChild(shape)
        }
        
        if (hourHandType == HourHandTypes.HourHandTypeSquaredHole) {
            
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: 1.5, y: 60))
            bezierPath.addLine(to: CGPoint(x: -1.5, y: 60))
            bezierPath.addLine(to: CGPoint(x: -1.5, y: 52))
            bezierPath.addLine(to: CGPoint(x: 1.5, y: 52))
            bezierPath.addLine(to: CGPoint(x: 1.5, y: 60))
            bezierPath.close()
            bezierPath.move(to: CGPoint(x: 4, y: 65))
            bezierPath.addCurve(to: CGPoint(x: 4, y: -10), controlPoint1: CGPoint(x: 4, y: 65), controlPoint2: CGPoint(x: 4, y: -10))
            bezierPath.addLine(to: CGPoint(x: -4, y: -10))
            bezierPath.addLine(to: CGPoint(x: -4, y: 65))
            bezierPath.addLine(to: CGPoint(x: 4, y: 65))
            bezierPath.addLine(to: CGPoint(x: 4, y: 65))
            bezierPath.close()
            
            let shape = SKShapeNode.init(path: bezierPath.cgPath)
            shape.fillColor = fillColor
            shape.strokeColor = strokeColor
            shape.lineWidth = lineWidth
            
            self.addChild(shape)
        }
        
        if (hourHandType == HourHandTypes.HourHandTypeSwiss) {
        
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: -5, y: -10))
            bezierPath.addLine(to: CGPoint(x: 5, y: -10))
            bezierPath.addLine(to: CGPoint(x: 3, y: 54))
            bezierPath.addLine(to: CGPoint(x: -3, y: 54))
            bezierPath.addLine(to: CGPoint(x: -5, y: -10))
            bezierPath.close()
            
            let shape = SKShapeNode.init(path: bezierPath.cgPath)
            shape.fillColor = fillColor
            shape.strokeColor = strokeColor
            shape.lineWidth = lineWidth
            
            self.addChild(shape)
        }
        
        if (hourHandType == HourHandTypes.HourHandTypeRounded) {
    
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: 3, y: 43.5))
            bezierPath.addCurve(to: CGPoint(x: 3, y: 5.77), controlPoint1: CGPoint(x: 3, y: 43.5), controlPoint2: CGPoint(x: 3, y: 20.44))
            bezierPath.addCurve(to: CGPoint(x: 6.5, y: 0), controlPoint1: CGPoint(x: 5.08, y: 4.68), controlPoint2: CGPoint(x: 6.5, y: 2.51))
            bezierPath.addCurve(to: CGPoint(x: -0, y: -6.5), controlPoint1: CGPoint(x: 6.5, y: -3.59), controlPoint2: CGPoint(x: 3.59, y: -6.5))
            bezierPath.addCurve(to: CGPoint(x: -6.5, y: 0), controlPoint1: CGPoint(x: -3.59, y: -6.5), controlPoint2: CGPoint(x: -6.5, y: -3.59))
            bezierPath.addCurve(to: CGPoint(x: -3, y: 5.77), controlPoint1: CGPoint(x: -6.5, y: 2.51), controlPoint2: CGPoint(x: -5.08, y: 4.68))
            bezierPath.addCurve(to: CGPoint(x: -3, y: 43.5), controlPoint1: CGPoint(x: -3, y: 20.44), controlPoint2: CGPoint(x: -3, y: 43.5))
            bezierPath.addCurve(to: CGPoint(x: 0, y: 46.5), controlPoint1: CGPoint(x: -3, y: 45.16), controlPoint2: CGPoint(x: -1.66, y: 46.5))
            bezierPath.addCurve(to: CGPoint(x: 3, y: 43.5), controlPoint1: CGPoint(x: 1.66, y: 46.5), controlPoint2: CGPoint(x: 3, y: 45.16))
            bezierPath.close()
            
            bezierPath.flatness = 0.01
            
            let shape = SKShapeNode.init(path: bezierPath.cgPath)
            shape.fillColor = fillColor
            shape.strokeColor = strokeColor
            shape.lineWidth = lineWidth
            
            self.addChild(shape)
        }
        
        if (hourHandType == HourHandTypes.HourHandTypeRoman) {
            
            let hourHandPath = UIBezierPath()
            hourHandPath.move(to: CGPoint(x: 0.08, y: 168.9))
            hourHandPath.addCurve(to: CGPoint(x: 4.82, y: 137.8), controlPoint1: CGPoint(x: 0.08, y: 168.9), controlPoint2: CGPoint(x: 4.82, y: 154.98))
            hourHandPath.addCurve(to: CGPoint(x: 1.44, y: 111.45), controlPoint1: CGPoint(x: 4.82, y: 126.69), controlPoint2: CGPoint(x: 2.84, y: 116.95))
            hourHandPath.addCurve(to: CGPoint(x: 6.42, y: 112.94), controlPoint1: CGPoint(x: 3.24, y: 112.24), controlPoint2: CGPoint(x: 5.17, y: 112.94))
            hourHandPath.addCurve(to: CGPoint(x: 11.58, y: 109.25), controlPoint1: CGPoint(x: 9.27, y: 112.94), controlPoint2: CGPoint(x: 11.58, y: 111.29))
            hourHandPath.addCurve(to: CGPoint(x: 6.42, y: 105.56), controlPoint1: CGPoint(x: 11.58, y: 107.21), controlPoint2: CGPoint(x: 9.27, y: 105.56))
            hourHandPath.addCurve(to: CGPoint(x: 2.15, y: 106.74), controlPoint1: CGPoint(x: 5.34, y: 105.56), controlPoint2: CGPoint(x: 3.73, y: 106.08))
            hourHandPath.addCurve(to: CGPoint(x: 8.47, y: 101.62), controlPoint1: CGPoint(x: 3.8, y: 103.33), controlPoint2: CGPoint(x: 6.1, y: 99.4))
            hourHandPath.addCurve(to: CGPoint(x: 14.95, y: 109.06), controlPoint1: CGPoint(x: 9.89, y: 102.82), controlPoint2: CGPoint(x: 13.58, y: 106.12))
            hourHandPath.addCurve(to: CGPoint(x: 15.68, y: 115.19), controlPoint1: CGPoint(x: 16.62, y: 112.03), controlPoint2: CGPoint(x: 15.98, y: 114.64))
            hourHandPath.addCurve(to: CGPoint(x: 22.09, y: 113.29), controlPoint1: CGPoint(x: 13.32, y: 117.2), controlPoint2: CGPoint(x: 23.02, y: 112.65))
            hourHandPath.addCurve(to: CGPoint(x: 22.12, y: 113.26), controlPoint1: CGPoint(x: 22.07, y: 113.24), controlPoint2: CGPoint(x: 22.12, y: 113.26))
            hourHandPath.addCurve(to: CGPoint(x: 19.06, y: 106.44), controlPoint1: CGPoint(x: 24.62, y: 112.97), controlPoint2: CGPoint(x: 24.25, y: 110.31))
            hourHandPath.addCurve(to: CGPoint(x: 9.03, y: 100.03), controlPoint1: CGPoint(x: 16.39, y: 104.29), controlPoint2: CGPoint(x: 12.06, y: 101.72))
            hourHandPath.addCurve(to: CGPoint(x: 13.21, y: 100.92), controlPoint1: CGPoint(x: 10.36, y: 100.54), controlPoint2: CGPoint(x: 11.77, y: 100.84))
            hourHandPath.addCurve(to: CGPoint(x: 22.75, y: 97.77), controlPoint1: CGPoint(x: 16.52, y: 101.1), controlPoint2: CGPoint(x: 20.01, y: 100.03))
            hourHandPath.addCurve(to: CGPoint(x: 27.82, y: 88.23), controlPoint1: CGPoint(x: 25.5, y: 95.54), controlPoint2: CGPoint(x: 27.47, y: 92.06))
            hourHandPath.addCurve(to: CGPoint(x: 27.17, y: 82.44), controlPoint1: CGPoint(x: 27.99, y: 86.34), controlPoint2: CGPoint(x: 27.79, y: 84.32))
            hourHandPath.addCurve(to: CGPoint(x: 24.16, y: 77.28), controlPoint1: CGPoint(x: 26.55, y: 80.55), controlPoint2: CGPoint(x: 25.51, y: 78.78))
            hourHandPath.addCurve(to: CGPoint(x: 13.21, y: 72.45), controlPoint1: CGPoint(x: 21.46, y: 74.25), controlPoint2: CGPoint(x: 17.34, y: 72.41))
            hourHandPath.addCurve(to: CGPoint(x: 11.41, y: 72.57), controlPoint1: CGPoint(x: 12.61, y: 72.45), controlPoint2: CGPoint(x: 12, y: 72.5))
            hourHandPath.addCurve(to: CGPoint(x: 19.11, y: 67.51), controlPoint1: CGPoint(x: 14.08, y: 71.03), controlPoint2: CGPoint(x: 17.09, y: 69.15))
            hourHandPath.addCurve(to: CGPoint(x: 22.1, y: 60.64), controlPoint1: CGPoint(x: 24.3, y: 63.65), controlPoint2: CGPoint(x: 24.6, y: 60.96))
            hourHandPath.addCurve(to: CGPoint(x: 15.77, y: 58.84), controlPoint1: CGPoint(x: 23.03, y: 61.27), controlPoint2: CGPoint(x: 13.43, y: 56.76))
            hourHandPath.addCurve(to: CGPoint(x: 14.97, y: 65.04), controlPoint1: CGPoint(x: 16.07, y: 59.42), controlPoint2: CGPoint(x: 16.68, y: 62.06))
            hourHandPath.addCurve(to: CGPoint(x: 8.38, y: 72.47), controlPoint1: CGPoint(x: 13.57, y: 67.98), controlPoint2: CGPoint(x: 9.83, y: 71.28))
            hourHandPath.addCurve(to: CGPoint(x: 2.15, y: 67.3), controlPoint1: CGPoint(x: 6.04, y: 74.65), controlPoint2: CGPoint(x: 3.77, y: 70.72))
            hourHandPath.addCurve(to: CGPoint(x: 6.28, y: 68.44), controlPoint1: CGPoint(x: 3.69, y: 67.93), controlPoint2: CGPoint(x: 5.23, y: 68.44))
            hourHandPath.addCurve(to: CGPoint(x: 11.45, y: 64.74), controlPoint1: CGPoint(x: 9.14, y: 68.44), controlPoint2: CGPoint(x: 11.45, y: 66.78))
            hourHandPath.addCurve(to: CGPoint(x: 6.28, y: 61.05), controlPoint1: CGPoint(x: 11.45, y: 62.71), controlPoint2: CGPoint(x: 9.14, y: 61.05))
            hourHandPath.addCurve(to: CGPoint(x: 1.31, y: 62.54), controlPoint1: CGPoint(x: 5.04, y: 61.05), controlPoint2: CGPoint(x: 3.1, y: 61.75))
            hourHandPath.addCurve(to: CGPoint(x: 4.7, y: 36.19), controlPoint1: CGPoint(x: 2.71, y: 57.04), controlPoint2: CGPoint(x: 4.7, y: 47.3))
            hourHandPath.addCurve(to: CGPoint(x: -0.03, y: -5.61), controlPoint1: CGPoint(x: 4.7, y: 19.01), controlPoint2: CGPoint(x: -0.03, y: -5.61))
            hourHandPath.addCurve(to: CGPoint(x: -4.78, y: 36.18), controlPoint1: CGPoint(x: -0.03, y: -5.61), controlPoint2: CGPoint(x: -4.78, y: 19.01))
            hourHandPath.addCurve(to: CGPoint(x: -1.4, y: 62.54), controlPoint1: CGPoint(x: -4.78, y: 47.29), controlPoint2: CGPoint(x: -2.8, y: 57.04))
            hourHandPath.addCurve(to: CGPoint(x: -6.37, y: 61.05), controlPoint1: CGPoint(x: -3.19, y: 61.75), controlPoint2: CGPoint(x: -5.13, y: 61.05))
            hourHandPath.addCurve(to: CGPoint(x: -11.54, y: 64.74), controlPoint1: CGPoint(x: -9.23, y: 61.05), controlPoint2: CGPoint(x: -11.54, y: 62.7))
            hourHandPath.addCurve(to: CGPoint(x: -6.37, y: 68.43), controlPoint1: CGPoint(x: -11.54, y: 66.78), controlPoint2: CGPoint(x: -9.23, y: 68.43))
            hourHandPath.addCurve(to: CGPoint(x: -2.11, y: 67.25), controlPoint1: CGPoint(x: -5.29, y: 68.43), controlPoint2: CGPoint(x: -3.69, y: 67.9))
            hourHandPath.addCurve(to: CGPoint(x: -8.42, y: 72.37), controlPoint1: CGPoint(x: -3.75, y: 70.66), controlPoint2: CGPoint(x: -6.06, y: 74.59))
            hourHandPath.addCurve(to: CGPoint(x: -14.91, y: 64.93), controlPoint1: CGPoint(x: -9.85, y: 71.17), controlPoint2: CGPoint(x: -13.54, y: 67.87))
            hourHandPath.addCurve(to: CGPoint(x: -15.63, y: 58.8), controlPoint1: CGPoint(x: -16.58, y: 61.96), controlPoint2: CGPoint(x: -15.93, y: 59.35))
            hourHandPath.addCurve(to: CGPoint(x: -22.05, y: 60.7), controlPoint1: CGPoint(x: -13.28, y: 56.79), controlPoint2: CGPoint(x: -22.98, y: 61.34))
            hourHandPath.addCurve(to: CGPoint(x: -22.08, y: 60.73), controlPoint1: CGPoint(x: -22.02, y: 60.75), controlPoint2: CGPoint(x: -22.08, y: 60.73))
            hourHandPath.addCurve(to: CGPoint(x: -19.01, y: 67.55), controlPoint1: CGPoint(x: -24.58, y: 61.02), controlPoint2: CGPoint(x: -24.21, y: 63.68))
            hourHandPath.addCurve(to: CGPoint(x: -10.31, y: 73.21), controlPoint1: CGPoint(x: -16.72, y: 69.4), controlPoint2: CGPoint(x: -13.19, y: 71.57))
            hourHandPath.addCurve(to: CGPoint(x: -15.02, y: 72.45), controlPoint1: CGPoint(x: -11.83, y: 72.7), controlPoint2: CGPoint(x: -13.42, y: 72.43))
            hourHandPath.addCurve(to: CGPoint(x: -25.83, y: 77.41), controlPoint1: CGPoint(x: -19.15, y: 72.42), controlPoint2: CGPoint(x: -23.25, y: 74.34))
            hourHandPath.addCurve(to: CGPoint(x: -29.45, y: 88.22), controlPoint1: CGPoint(x: -28.48, y: 80.42), controlPoint2: CGPoint(x: -29.76, y: 84.45))
            hourHandPath.addCurve(to: CGPoint(x: -29.37, y: 88.85), controlPoint1: CGPoint(x: -29.45, y: 88.3), controlPoint2: CGPoint(x: -29.37, y: 88.85))
            hourHandPath.addCurve(to: CGPoint(x: -29.26, y: 89.61), controlPoint1: CGPoint(x: -29.34, y: 89.09), controlPoint2: CGPoint(x: -29.31, y: 89.36))
            hourHandPath.addCurve(to: CGPoint(x: -28.9, y: 90.98), controlPoint1: CGPoint(x: -29.16, y: 90.08), controlPoint2: CGPoint(x: -29.05, y: 90.53))
            hourHandPath.addCurve(to: CGPoint(x: -27.72, y: 93.48), controlPoint1: CGPoint(x: -28.61, y: 91.86), controlPoint2: CGPoint(x: -28.21, y: 92.71))
            hourHandPath.addCurve(to: CGPoint(x: -24.11, y: 97.3), controlPoint1: CGPoint(x: -26.75, y: 95.03), controlPoint2: CGPoint(x: -25.47, y: 96.29))
            hourHandPath.addCurve(to: CGPoint(x: -14.99, y: 100.92), controlPoint1: CGPoint(x: -21.39, y: 99.27), controlPoint2: CGPoint(x: -18.43, y: 100.76))
            hourHandPath.addCurve(to: CGPoint(x: -5.48, y: 97.76), controlPoint1: CGPoint(x: -11.75, y: 101.09), controlPoint2: CGPoint(x: -8.21, y: 100.03))
            hourHandPath.addCurve(to: CGPoint(x: -0.83, y: 90.45), controlPoint1: CGPoint(x: -3.28, y: 95.95), controlPoint2: CGPoint(x: -1.6, y: 93.43))
            hourHandPath.addCurve(to: CGPoint(x: -0.67, y: 90.98), controlPoint1: CGPoint(x: -0.78, y: 90.62), controlPoint2: CGPoint(x: -0.73, y: 90.8))
            hourHandPath.addCurve(to: CGPoint(x: 0.51, y: 93.48), controlPoint1: CGPoint(x: -0.38, y: 91.87), controlPoint2: CGPoint(x: 0.03, y: 92.71))
            hourHandPath.addCurve(to: CGPoint(x: 4.12, y: 97.3), controlPoint1: CGPoint(x: 1.48, y: 95.03), controlPoint2: CGPoint(x: 2.77, y: 96.29))
            hourHandPath.addCurve(to: CGPoint(x: 5.33, y: 98.14), controlPoint1: CGPoint(x: 4.52, y: 97.6), controlPoint2: CGPoint(x: 4.93, y: 97.87))
            hourHandPath.addCurve(to: CGPoint(x: 0.35, y: 107.53), controlPoint1: CGPoint(x: 3.61, y: 97.93), controlPoint2: CGPoint(x: 1.42, y: 103.54))
            hourHandPath.addCurve(to: CGPoint(x: 0.09, y: 106.71), controlPoint1: CGPoint(x: 0.19, y: 107), controlPoint2: CGPoint(x: 0.09, y: 106.71))
            hourHandPath.addCurve(to: CGPoint(x: -0.18, y: 107.54), controlPoint1: CGPoint(x: 0.09, y: 106.71), controlPoint2: CGPoint(x: -0.01, y: 107))
            hourHandPath.addCurve(to: CGPoint(x: -0.34, y: 107.47), controlPoint1: CGPoint(x: -0.23, y: 107.52), controlPoint2: CGPoint(x: -0.28, y: 107.49))
            hourHandPath.addCurve(to: CGPoint(x: -5.49, y: 98.24), controlPoint1: CGPoint(x: -1.46, y: 103.28), controlPoint2: CGPoint(x: -3.7, y: 97.37))
            hourHandPath.addCurve(to: CGPoint(x: -19.06, y: 106.48), controlPoint1: CGPoint(x: -5.16, y: 98), controlPoint2: CGPoint(x: -14.56, y: 102.82))
            hourHandPath.addCurve(to: CGPoint(x: -22.05, y: 113.35), controlPoint1: CGPoint(x: -24.26, y: 110.34), controlPoint2: CGPoint(x: -24.55, y: 113.03))
            hourHandPath.addCurve(to: CGPoint(x: -22.04, y: 113.31), controlPoint1: CGPoint(x: -22.09, y: 113.33), controlPoint2: CGPoint(x: -22.04, y: 113.31))
            hourHandPath.addCurve(to: CGPoint(x: -15.73, y: 115.15), controlPoint1: CGPoint(x: -22.99, y: 112.72), controlPoint2: CGPoint(x: -13.38, y: 117.23))
            hourHandPath.addCurve(to: CGPoint(x: -14.93, y: 108.95), controlPoint1: CGPoint(x: -16.02, y: 114.57), controlPoint2: CGPoint(x: -16.64, y: 111.93))
            hourHandPath.addCurve(to: CGPoint(x: -8.34, y: 101.52), controlPoint1: CGPoint(x: -13.52, y: 106.01), controlPoint2: CGPoint(x: -9.78, y: 102.71))
            hourHandPath.addCurve(to: CGPoint(x: -2.1, y: 106.69), controlPoint1: CGPoint(x: -6, y: 99.34), controlPoint2: CGPoint(x: -3.73, y: 103.27))
            hourHandPath.addCurve(to: CGPoint(x: -6.24, y: 105.55), controlPoint1: CGPoint(x: -3.64, y: 106.05), controlPoint2: CGPoint(x: -5.19, y: 105.55))
            hourHandPath.addCurve(to: CGPoint(x: -11.41, y: 109.24), controlPoint1: CGPoint(x: -9.09, y: 105.55), controlPoint2: CGPoint(x: -11.41, y: 107.21))
            hourHandPath.addCurve(to: CGPoint(x: -6.24, y: 112.94), controlPoint1: CGPoint(x: -11.41, y: 111.28), controlPoint2: CGPoint(x: -9.09, y: 112.94))
            hourHandPath.addCurve(to: CGPoint(x: -1.27, y: 111.45), controlPoint1: CGPoint(x: -5, y: 112.94), controlPoint2: CGPoint(x: -3.06, y: 112.24))
            hourHandPath.addCurve(to: CGPoint(x: -4.65, y: 137.8), controlPoint1: CGPoint(x: -2.67, y: 116.95), controlPoint2: CGPoint(x: -4.65, y: 126.69))
            hourHandPath.addCurve(to: CGPoint(x: 0.08, y: 168.9), controlPoint1: CGPoint(x: -4.66, y: 154.98), controlPoint2: CGPoint(x: 0.08, y: 168.9))
            hourHandPath.addLine(to: CGPoint(x: 0.08, y: 168.9))
            hourHandPath.close()
            hourHandPath.move(to: CGPoint(x: -18.91, y: 97.59))
            hourHandPath.addCurve(to: CGPoint(x: -21.97, y: 95.16), controlPoint1: CGPoint(x: -20.14, y: 97.11), controlPoint2: CGPoint(x: -21.24, y: 96.25))
            hourHandPath.addCurve(to: CGPoint(x: -23.27, y: 91.63), controlPoint1: CGPoint(x: -22.71, y: 94.07), controlPoint2: CGPoint(x: -23.11, y: 92.82))
            hourHandPath.addCurve(to: CGPoint(x: -23.38, y: 89.88), controlPoint1: CGPoint(x: -23.35, y: 91.03), controlPoint2: CGPoint(x: -23.38, y: 90.45))
            hourHandPath.addCurve(to: CGPoint(x: -23.34, y: 89.05), controlPoint1: CGPoint(x: -23.37, y: 89.6), controlPoint2: CGPoint(x: -23.37, y: 89.31))
            hourHandPath.addCurve(to: CGPoint(x: -23.31, y: 88.7), controlPoint1: CGPoint(x: -23.33, y: 88.93), controlPoint2: CGPoint(x: -23.32, y: 88.83))
            hourHandPath.addCurve(to: CGPoint(x: -23.27, y: 88.22), controlPoint1: CGPoint(x: -23.31, y: 88.7), controlPoint2: CGPoint(x: -23.29, y: 88.37))
            hourHandPath.addLine(to: CGPoint(x: -23.26, y: 88.14))
            hourHandPath.addCurve(to: CGPoint(x: -20.24, y: 83), controlPoint1: CGPoint(x: -22.95, y: 86), controlPoint2: CGPoint(x: -21.8, y: 84.16))
            hourHandPath.addCurve(to: CGPoint(x: -15.03, y: 81.33), controlPoint1: CGPoint(x: -18.64, y: 81.85), controlPoint2: CGPoint(x: -16.84, y: 81.32))
            hourHandPath.addCurve(to: CGPoint(x: -6.99, y: 88.24), controlPoint1: CGPoint(x: -11.48, y: 81.34), controlPoint2: CGPoint(x: -7.77, y: 83.81))
            hourHandPath.addCurve(to: CGPoint(x: -6.95, y: 88.42), controlPoint1: CGPoint(x: -6.96, y: 88.32), controlPoint2: CGPoint(x: -6.95, y: 88.42))
            hourHandPath.addLine(to: CGPoint(x: -6.92, y: 88.62))
            hourHandPath.addLine(to: CGPoint(x: -6.88, y: 89.03))
            hourHandPath.addCurve(to: CGPoint(x: -6.85, y: 89.85), controlPoint1: CGPoint(x: -6.86, y: 89.3), controlPoint2: CGPoint(x: -6.85, y: 89.57))
            hourHandPath.addCurve(to: CGPoint(x: -7.06, y: 91.52), controlPoint1: CGPoint(x: -6.87, y: 90.4), controlPoint2: CGPoint(x: -6.94, y: 90.96))
            hourHandPath.addCurve(to: CGPoint(x: -8.54, y: 94.7), controlPoint1: CGPoint(x: -7.33, y: 92.62), controlPoint2: CGPoint(x: -7.81, y: 93.74))
            hourHandPath.addCurve(to: CGPoint(x: -15.06, y: 98.18), controlPoint1: CGPoint(x: -10.01, y: 96.66), controlPoint2: CGPoint(x: -12.36, y: 98.04))
            hourHandPath.addCurve(to: CGPoint(x: -18.91, y: 97.59), controlPoint1: CGPoint(x: -16.3, y: 98.27), controlPoint2: CGPoint(x: -17.69, y: 98.07))
            hourHandPath.close()
            hourHandPath.move(to: CGPoint(x: 9.32, y: 97.6))
            hourHandPath.addCurve(to: CGPoint(x: 6.26, y: 95.17), controlPoint1: CGPoint(x: 8.09, y: 97.11), controlPoint2: CGPoint(x: 7, y: 96.25))
            hourHandPath.addCurve(to: CGPoint(x: 4.96, y: 91.64), controlPoint1: CGPoint(x: 5.52, y: 94.08), controlPoint2: CGPoint(x: 5.12, y: 92.83))
            hourHandPath.addCurve(to: CGPoint(x: 4.86, y: 89.89), controlPoint1: CGPoint(x: 4.88, y: 91.04), controlPoint2: CGPoint(x: 4.85, y: 90.45))
            hourHandPath.addCurve(to: CGPoint(x: 4.89, y: 89.05), controlPoint1: CGPoint(x: 4.87, y: 89.6), controlPoint2: CGPoint(x: 4.87, y: 89.32))
            hourHandPath.addCurve(to: CGPoint(x: 4.92, y: 88.7), controlPoint1: CGPoint(x: 4.91, y: 88.93), controlPoint2: CGPoint(x: 4.91, y: 88.84))
            hourHandPath.addCurve(to: CGPoint(x: 4.96, y: 88.22), controlPoint1: CGPoint(x: 4.92, y: 88.7), controlPoint2: CGPoint(x: 4.95, y: 88.38))
            hourHandPath.addLine(to: CGPoint(x: 4.98, y: 88.15))
            hourHandPath.addCurve(to: CGPoint(x: 7.99, y: 83), controlPoint1: CGPoint(x: 5.28, y: 86), controlPoint2: CGPoint(x: 6.44, y: 84.16))
            hourHandPath.addCurve(to: CGPoint(x: 13.21, y: 81.33), controlPoint1: CGPoint(x: 9.59, y: 81.85), controlPoint2: CGPoint(x: 11.39, y: 81.32))
            hourHandPath.addCurve(to: CGPoint(x: 18.29, y: 83.15), controlPoint1: CGPoint(x: 15.02, y: 81.35), controlPoint2: CGPoint(x: 16.79, y: 81.96))
            hourHandPath.addCurve(to: CGPoint(x: 21.26, y: 88.22), controlPoint1: CGPoint(x: 19.75, y: 84.34), controlPoint2: CGPoint(x: 20.91, y: 86.09))
            hourHandPath.addCurve(to: CGPoint(x: 19.69, y: 94.71), controlPoint1: CGPoint(x: 21.64, y: 90.33), controlPoint2: CGPoint(x: 21.16, y: 92.75))
            hourHandPath.addCurve(to: CGPoint(x: 13.21, y: 98.19), controlPoint1: CGPoint(x: 18.24, y: 96.66), controlPoint2: CGPoint(x: 15.84, y: 98.04))
            hourHandPath.addCurve(to: CGPoint(x: 9.32, y: 97.6), controlPoint1: CGPoint(x: 11.9, y: 98.28), controlPoint2: CGPoint(x: 10.56, y: 98.07))
            hourHandPath.close()
            hourHandPath.move(to: CGPoint(x: -0.78, y: 83.49))
            hourHandPath.addCurve(to: CGPoint(x: -1.06, y: 82.44), controlPoint1: CGPoint(x: -0.87, y: 83.13), controlPoint2: CGPoint(x: -0.95, y: 82.78))
            hourHandPath.addCurve(to: CGPoint(x: -4.08, y: 77.27), controlPoint1: CGPoint(x: -1.69, y: 80.55), controlPoint2: CGPoint(x: -2.72, y: 78.78))
            hourHandPath.addLine(to: CGPoint(x: -5.8, y: 75.67))
            hourHandPath.addCurve(to: CGPoint(x: -5.55, y: 75.78), controlPoint1: CGPoint(x: -5.6, y: 75.77), controlPoint2: CGPoint(x: -5.5, y: 75.81))
            hourHandPath.addCurve(to: CGPoint(x: -0.31, y: 66.46), controlPoint1: CGPoint(x: -3.79, y: 76.64), controlPoint2: CGPoint(x: -1.43, y: 70.65))
            hourHandPath.addCurve(to: CGPoint(x: -0.05, y: 67.28), controlPoint1: CGPoint(x: -0.14, y: 66.99), controlPoint2: CGPoint(x: -0.05, y: 67.28))
            hourHandPath.addCurve(to: CGPoint(x: 0.22, y: 66.45), controlPoint1: CGPoint(x: -0.05, y: 67.28), controlPoint2: CGPoint(x: 0.05, y: 66.99))
            hourHandPath.addCurve(to: CGPoint(x: 0.38, y: 66.52), controlPoint1: CGPoint(x: 0.27, y: 66.47), controlPoint2: CGPoint(x: 0.33, y: 66.5))
            hourHandPath.addCurve(to: CGPoint(x: 4.4, y: 75.51), controlPoint1: CGPoint(x: 1.27, y: 69.86), controlPoint2: CGPoint(x: 2.88, y: 74.29))
            hourHandPath.addCurve(to: CGPoint(x: 2.4, y: 77.41), controlPoint1: CGPoint(x: 3.67, y: 76.08), controlPoint2: CGPoint(x: 2.99, y: 76.71))
            hourHandPath.addCurve(to: CGPoint(x: -0.78, y: 83.49), controlPoint1: CGPoint(x: 0.85, y: 79.17), controlPoint2: CGPoint(x: -0.21, y: 81.29))
            hourHandPath.close()
            
            hourHandPath.flatness = 0.1
            
            let shape = SKShapeNode.init(path: hourHandPath.cgPath)
            shape.setScale(0.35)
            shape.fillColor = fillColor
            shape.strokeColor = strokeColor
            shape.lineWidth = lineWidth
            
            self.addChild(shape)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
