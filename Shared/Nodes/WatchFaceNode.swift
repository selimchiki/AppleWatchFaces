//
//  WatchFaceNode.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/9/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import Foundation
import SpriteKit

class WatchFaceNode: SKShapeNode {
    
    init(clockSetting: ClockSetting, size: CGSize) {
        super.init()
        
        self.name = "watchFaceNode"
        
        if let clockFaceSettings = clockSetting.clockFaceSettings {
            
            let backgroundNode = FaceBackgroundNode.init(backgroundType: FaceBackgroundTypes.FaceBackgroundTypeFilled , material: clockSetting.clockCasingMaterialName)
            backgroundNode.name = "background"
            backgroundNode.zPosition = 0
            
            self.addChild(backgroundNode)
            
            let backgroundShapeNode = FaceBackgroundNode.init(backgroundType: clockSetting.faceBackgroundType , material: clockSetting.clockFaceMaterialName)
            backgroundShapeNode.name = "backgroundShape"
            backgroundShapeNode.zPosition = 1
            
            self.addChild(backgroundShapeNode)
            
            let secondHandFillColor = SKColor.init(hexString: clockFaceSettings.secondHandMaterialName)
            let secHandNode = SecondHandNode.init(secondHandType: clockFaceSettings.secondHandType, material: clockFaceSettings.secondHandMaterialName, strokeColor: secondHandFillColor, lineWidth: 1.0)
            secHandNode.name = "secondHand"
            secHandNode.zPosition = 4
            
            self.addChild(secHandNode)
            
            var minuteHandStrokeColor = SKColor.init(hexString: clockFaceSettings.minuteHandMaterialName)
            if (clockFaceSettings.shouldShowHandOutlines) {
                minuteHandStrokeColor = SKColor.init(hexString: clockFaceSettings.handOutlineMaterialName)
            }
            let minHandNode = MinuteHandNode.init(minuteHandType: clockFaceSettings.minuteHandType, material: clockFaceSettings.minuteHandMaterialName, strokeColor: minuteHandStrokeColor, lineWidth: 1.0)
            minHandNode.name = "minuteHand"
            minHandNode.zPosition = 3
            
            self.addChild(minHandNode)
            
            var hourHandStrokeColor = SKColor.init(hexString: clockFaceSettings.hourHandMaterialName)
            if (clockFaceSettings.shouldShowHandOutlines) {
                hourHandStrokeColor = SKColor.init(hexString: clockFaceSettings.handOutlineMaterialName)
            }
        
            let hourHandNode = HourHandNode.init(hourHandType: clockFaceSettings.hourHandType, material: clockFaceSettings.hourHandMaterialName, strokeColor: hourHandStrokeColor, lineWidth: 1.0)
            hourHandNode.name = "hourHand"
            hourHandNode.zPosition = 2
            
            self.addChild(hourHandNode)
        
            var currentDistance = Float(1.0)
            //loop through ring settings and render rings from outside to inside
            for ringSetting in clockFaceSettings.ringSettings {
                
                let desiredMaterialIndex = ringSetting.ringMaterialDesiredThemeColorIndex
                var material = ""
                if (desiredMaterialIndex<=clockFaceSettings.ringMaterials.count-1) {
                    material = clockFaceSettings.ringMaterials[desiredMaterialIndex]
                } else {
                    material = clockFaceSettings.ringMaterials[clockFaceSettings.ringMaterials.count-1]
                }
                
                generateRingNode(
                    self,
                    patternTotal: ringSetting.ringPatternTotal,
                    patternArray: ringSetting.ringPattern,
                    ringType: ringSetting.ringType,
                    material: material,
                    currentDistance: currentDistance,
                    clockFaceSettings: clockFaceSettings,
                    ringSettings: ringSetting,
                    renderNumbers: true,
                    renderShapes: true)
                
                generateTextRingNode(
                    self,
                    patternTotal: ringSetting.ringPatternTotal,
                    patternArray: ringSetting.ringPattern,
                    ringType: ringSetting.ringType,
                    material: material,
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
    
    func generateTextRingNode( _ clockFaceNode: SKShapeNode, patternTotal: Int, patternArray: [Int], ringType: RingTypes, material: String, currentDistance: Float, clockFaceSettings: ClockFaceSetting, ringSettings: ClockRingSetting, renderNumbers: Bool, renderShapes: Bool ) {
        
        // exit if pattern array is empty
        if (patternArray.count == 0) { return }
        
        var patternCounter = 0
        let sizeMultiplier:CGFloat = CGFloat(SKWatchScene.sizeMulitplier)
        
        generateLoop: for outerRingIndex in 0...(patternTotal-1) {
            //dont draw when pattern == 0
            var doDraw = true
            
            var newNode = SKNode()
            
            if ( patternArray[patternCounter] == 0) { doDraw = false }
            
            patternCounter = patternCounter + 1
            if (patternCounter >= patternArray.count) { patternCounter = 0 }
            
            if (!doDraw) { continue }
            
            let angleDiv = patternTotal
            let angleOffset = -1.0 * Float(Double.pi*2) / Float(angleDiv)  * Float(outerRingIndex) + Float(Double.pi/2)
            
            let cx:Float = 0.0 //center x
            let cy:Float = 0.0 //center y
            
            let xpos:CGFloat = CGFloat(cx + currentDistance * cos(angleOffset))
            let ypos:CGFloat = CGFloat(cy + currentDistance * sin(angleOffset))
            
            var numberToRender = outerRingIndex
            if numberToRender == 0 { numberToRender = patternTotal }
            
            //force small totals to show as 12s
            if patternTotal < 12 {
                numberToRender = numberToRender * ( 12 / patternTotal )
            }
            
            if (renderNumbers && ringType == RingTypes.RingTypeTextRotatingNode) {
                newNode  = NumberTextNode.init(
                    numberTextType: ringSettings.textType,
                    textSize: ringSettings.textSize,
                    currentNum: numberToRender,
                    totalNum: patternTotal,
                    shouldDisplayRomanNumerals: clockFaceSettings.shouldShowRomanNumeralText,
                    pivotMode: 0, fillColor: SKColor.init(hexString: material))
                
                let angleForQuad = Float(Double.pi/2) - angleOffset
                let quadrandt = MathFunctions.getQuadrant(angleForQuad)
                
                //print("minText num: ",numberToRender, "angle: ", angleForQuad, "quad:", quadrandt )
                
                var counterRotAngle = Float( -angleForQuad )
                if (quadrandt > 1 && quadrandt < 4) { counterRotAngle = -angleForQuad + Float( Double.pi ) }
                
                newNode.zRotation = CGFloat(counterRotAngle)
                //newNode.eulerAngles = SCNVector3Make( 0, 0, counterRotAngle )
            }
            
            if (renderNumbers && ringType == RingTypes.RingTypeTextNode) {
                //print("patternDraw")
                
                newNode  = NumberTextNode.init(
                    numberTextType: ringSettings.textType,
                    textSize: ringSettings.textSize,
                    currentNum: numberToRender,
                    totalNum: patternTotal,
                    shouldDisplayRomanNumerals: clockFaceSettings.shouldShowRomanNumeralText,
                    pivotMode: 0, fillColor: SKColor.init(hexString: material))
            }
            
            //newNode.geometry?.firstMaterial? = material
            newNode.position = CGPoint.init(x: xpos*sizeMultiplier, y: ypos*sizeMultiplier)
            newNode.zPosition = 1
            clockFaceNode.addChild(newNode)
        }
    }
    
    func generateRingNode( _ clockFaceNode: SKShapeNode, patternTotal: Int, patternArray: [Int], ringType: RingTypes, material: String, currentDistance: Float, clockFaceSettings: ClockFaceSetting,
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
            
            let outerRingNode =
                FaceIndicatorNode.init(indicatorType:  ringSettings.indicatorType, size: ringSettings.indicatorSize, fillColor: SKColor.init(hexString: material))
            
            let angleDiv = patternTotal
            let angleOffset = -1.0 * Float(Double.pi*2) / Float(angleDiv)  * Float(outerRingIndex) + Float(Double.pi/2)
            
            outerRingNode.zRotation = CGFloat(Double.pi/2)
            
            var numberToRender = outerRingIndex
            if numberToRender == 0 { numberToRender = patternTotal }
        
            //debugPrint("CD:" + String(currentDistance))
            outerRingNode.position = CGPoint.init(x: Double(currentDistance * sizeMultiplier), y: 0.0)
            
            let outerRingParentNode = SKNode.init()
            outerRingParentNode.zRotation = CGFloat(angleOffset)
            
            outerRingParentNode.addChild(outerRingNode)
            outerRingParentNode.zPosition = 1
            clockFaceNode.addChild(outerRingParentNode)
        }
        
        
    }
    
    func hideHands() {
        if let secondHand = self.childNode(withName: "secondHand") {
            secondHand.isHidden = true
        }
        if let minuteHand = self.childNode(withName: "minuteHand") {
            minuteHand.isHidden = true
        }
        if let hourHand = self.childNode(withName: "hourHand") {
            hourHand.isHidden = true
        }
    }
    
    func positionHands( sec: CGFloat, min: CGFloat, hour: CGFloat ) {
        if let secondHand = self.childNode(withName: "secondHand") {
            secondHand.zRotation = -1 * deg2rad(sec * 6)
        }
        if let minuteHand = self.childNode(withName: "minuteHand") {
            minuteHand.zRotation = -1 * deg2rad(min * 6)
        }
        if let hourHand = self.childNode(withName: "hourHand") {
            hourHand.zRotation = -1 * deg2rad(hour * 30 + min/2)
        }
    }
    
    func setToTime() {
        // Called before each frame is rendered
        let date = Date()
        let calendar = Calendar.current
        
        let hour = CGFloat(calendar.component(.hour, from: date))
        let minutes = CGFloat(calendar.component(.minute, from: date))
        let seconds = CGFloat(calendar.component(.second, from: date))
        
        positionHands(sec: seconds, min: minutes, hour: hour)
    }
    
    func setToScreenShotTime() {
        positionHands(sec: AppUISettings.screenShotSeconds, min: AppUISettings.screenShotMinutes, hour: AppUISettings.screenShotHour)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
}
