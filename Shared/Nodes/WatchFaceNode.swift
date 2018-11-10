//
//  WatchFaceNode.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/9/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import Foundation
import SpriteKit

class WatchFaceNode: SKSpriteNode {
    
    init(clockSetting: ClockSetting, size: CGSize) {
        super.init(texture: nil, color: SKColor.clear, size: size)
        
        self.name = "watchFaceNode"
        
        if let clockFaceSettings = clockSetting.clockFaceSettings {
            
            //add background shape
            let background = SKShapeNode.init(circleOfRadius: SKWatchScene.sizeMulitplier*1.05)
            background.name = "background"
            background.fillColor = SKColor.init(hexString: clockSetting.clockFaceMaterialName)
            background.strokeColor = SKColor.init(hexString: clockSetting.clockCasingMaterialName)
            
            self.addChild(background)
            
            let secondHandFillColor = SKColor.init(hexString: clockFaceSettings.secondHandMaterialName)
            let secHandNode = SecondHandNode.init(secondHandType: clockFaceSettings.secondHandType, fillColor: secondHandFillColor)
            secHandNode.name = "secondHand"
            secHandNode.zPosition = 2
            
            self.addChild(secHandNode)
            
            let minuteHandFillColor = SKColor.init(hexString: clockFaceSettings.minuteHandMaterialName)
            let minHandNode = MinuteHandNode.init(minuteHandType: clockFaceSettings.minuteHandType, fillColor: minuteHandFillColor)
            minHandNode.name = "minuteHand"
            minHandNode.zPosition = 1
            
            self.addChild(minHandNode)
            
            let hourHandFillColor = SKColor.init(hexString: clockFaceSettings.hourHandMaterialName)
            let hourHandNode = HourHandNode.init(hourHandType: clockFaceSettings.hourHandType, fillColor: hourHandFillColor)
            hourHandNode.name = "hourHand"
            hourHandNode.zPosition = 1
            
            self.addChild(hourHandNode)
        
            var currentDistance = Float(1.0)
            //loop through ring settings and render rings from outside to inside
            for ringSetting in clockFaceSettings.ringSettings {
                generateRingNode(
                    self,
                    patternTotal: ringSetting.ringPatternTotal,
                    patternArray: ringSetting.ringPattern,
                    ringType: ringSetting.ringType,
                    material: ringSetting.ringMaterialName,
                    currentDistance: currentDistance,
                    clockFaceSettings: clockFaceSettings,
                    ringSettings: ringSetting,
                    renderNumbers: true,
                    renderShapes: true)
                
                //move it closer to center
                currentDistance = currentDistance - ringSetting.ringWidth
            }
            
        }

    }
    
    func generateRingNode( _ clockFaceNode: SKSpriteNode, patternTotal: Int, patternArray: [Int], ringType: RingTypes, material: String, currentDistance: Float, clockFaceSettings: ClockFaceSetting,
                           ringSettings: ClockRingSetting, renderNumbers: Bool, renderShapes: Bool ) {
        
        //just exit for spacer
        if (ringType == RingTypes.RingTypeSpacer) { return }
        
        //only render shapes
        if (ringType != RingTypes.RingTypeShapeNode) { return }
        
        let sizeMultiplier:Float = Float(SKWatchScene.sizeMulitplier)
        
        // exit if pattern array is empty
        if (patternArray.count == 0) { return }
        
        var patternCounter = 0
        
        generateLoop: for outerRingIndex in 0...(patternTotal-1) {
            //dont draw when pattern == 0
            var doDraw = true
            if ( patternArray[patternCounter] == 0) { doDraw = false }
            patternCounter = patternCounter + 1
            if (patternCounter >= patternArray.count) { patternCounter = 0 }
            
            if (!doDraw) { continue }
            
            let outerRingNode = FaceIndicatorNode.init(indicatorType:  ringSettings.indicatorType, size: ringSettings.indicatorSize, fillColor: SKColor.init(hexString: material))
            
            let angleDiv = patternTotal
            let angleOffset = -1.0 * Float(Double.pi*2) / Float(angleDiv)  * Float(outerRingIndex) + Float(Double.pi/2)
            
            outerRingNode.zRotation = CGFloat(Double.pi/2)
            
            var numberToRender = outerRingIndex
            if numberToRender == 0 { numberToRender = patternTotal }
        
            debugPrint("CD:" + String(currentDistance))
            outerRingNode.position = CGPoint.init(x: Double(currentDistance * sizeMultiplier), y: 0.0)
            
            let outerRingParentNode = SKNode.init()
            outerRingParentNode.zRotation = CGFloat(angleOffset)
            
            outerRingParentNode.addChild(outerRingNode)
            clockFaceNode.addChild(outerRingParentNode)
        }
        
        
    }
    
    func setToTime() {
        // Called before each frame is rendered
        let date = Date()
        let calendar = Calendar.current
        
        let hour = CGFloat(calendar.component(.hour, from: date))
        let minutes = CGFloat(calendar.component(.minute, from: date))
        let seconds = CGFloat(calendar.component(.second, from: date))
        
        if let secondHand = self.childNode(withName: "secondHand") {
            secondHand.zRotation = -1 * deg2rad(seconds * 6)
        }
        if let minuteHand = self.childNode(withName: "minuteHand") {
            minuteHand.zRotation = -1 * deg2rad(minutes * 6)
        }
        if let hourHand = self.childNode(withName: "hourHand") {
            hourHand.zRotation = -1 * deg2rad(hour * 30 + minutes/2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
}
