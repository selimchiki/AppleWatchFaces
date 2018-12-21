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
    
    var secondHandMovement: SecondHandMovements = .SecondHandMovementStep
    var minuteHandMovement: MinuteHandMovements = .MinuteHandMovementStep
    
    init(clockSetting: ClockSetting, size: CGSize) {
        super.init()
        
        self.name = "watchFaceNode"
        
        //nothing to without these settings
        guard let clockFaceSettings = clockSetting.clockFaceSettings else { return }
        
        //debugPrint("secondhandMovement:" + clockFaceSettings.secondHandMovement.rawValue)
        //debugPrint("minuteHandMovement:" + clockFaceSettings.minuteHandMovement.rawValue)
        self.secondHandMovement = clockFaceSettings.secondHandMovement
        self.minuteHandMovement = clockFaceSettings.minuteHandMovement
        
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
        
        let totalWidth = CGFloat(SKWatchScene.sizeMulitplier * 2)
        
        let ringShapePath = UIBezierPath()
        
        if clockFaceSettings.ringRenderShape == .RingRenderShapeRoundedRect {
            ringShapePath.move(to: CGPoint(x: 0, y: -100))
            ringShapePath.addLine(to: CGPoint(x: 69.43, y: -100))
            ringShapePath.addCurve(to: CGPoint(x: 86.6, y: -98.69), controlPoint1: CGPoint(x: 78.23, y: -100), controlPoint2: CGPoint(x: 82.63, y: -100))
            ringShapePath.addLine(to: CGPoint(x: 87.37, y: -98.5))
            ringShapePath.addCurve(to: CGPoint(x: 98.5, y: -87.37), controlPoint1: CGPoint(x: 92.54, y: -96.62), controlPoint2: CGPoint(x: 96.62, y: -92.54))
            ringShapePath.addCurve(to: CGPoint(x: 100, y: -69.43), controlPoint1: CGPoint(x: 100, y: -82.63), controlPoint2: CGPoint(x: 100, y: -78.23))
            ringShapePath.addLine(to: CGPoint(x: 100, y: 69.43))
            ringShapePath.addCurve(to: CGPoint(x: 98.69, y: 86.6), controlPoint1: CGPoint(x: 100, y: 78.23), controlPoint2: CGPoint(x: 100, y: 82.63))
            ringShapePath.addLine(to: CGPoint(x: 98.5, y: 87.37))
            ringShapePath.addCurve(to: CGPoint(x: 87.37, y: 98.5), controlPoint1: CGPoint(x: 96.62, y: 92.54), controlPoint2: CGPoint(x: 92.54, y: 96.62))
            ringShapePath.addCurve(to: CGPoint(x: 69.43, y: 100), controlPoint1: CGPoint(x: 82.63, y: 100), controlPoint2: CGPoint(x: 78.23, y: 100))
            ringShapePath.addLine(to: CGPoint(x: -69.43, y: 100))
            ringShapePath.addCurve(to: CGPoint(x: -86.6, y: 98.69), controlPoint1: CGPoint(x: -78.23, y: 100), controlPoint2: CGPoint(x: -82.63, y: 100))
            ringShapePath.addLine(to: CGPoint(x: -87.37, y: 98.5))
            ringShapePath.addCurve(to: CGPoint(x: -98.5, y: 87.37), controlPoint1: CGPoint(x: -92.54, y: 96.62), controlPoint2: CGPoint(x: -96.62, y: 92.54))
            ringShapePath.addCurve(to: CGPoint(x: -100, y: 69.43), controlPoint1: CGPoint(x: -100, y: 82.63), controlPoint2: CGPoint(x: -100, y: 78.23))
            ringShapePath.addLine(to: CGPoint(x: -100, y: -69.43))
            ringShapePath.addCurve(to: CGPoint(x: -98.69, y: -86.6), controlPoint1: CGPoint(x: -100, y: -78.23), controlPoint2: CGPoint(x: -100, y: -82.63))
            ringShapePath.addLine(to: CGPoint(x: -98.5, y: -87.37))
            ringShapePath.addCurve(to: CGPoint(x: -87.37, y: -98.5), controlPoint1: CGPoint(x: -96.62, y: -92.54), controlPoint2: CGPoint(x: -92.54, y: -96.62))
            ringShapePath.addCurve(to: CGPoint(x: -69.43, y: -100), controlPoint1: CGPoint(x: -82.63, y: -100), controlPoint2: CGPoint(x: -78.23, y: -100))
            ringShapePath.close()
            ringShapePath.apply(CGAffineTransform.init(scaleX: 1, y: -1.275)) //flip and stretch
        }

        if clockFaceSettings.ringRenderShape == .RingRenderShapeCircle {
            ringShapePath.addArc(withCenter: CGPoint.zero, radius: totalWidth/2, startAngle: CGFloat(Double.pi/2), endAngle: -CGFloat(Double.pi*2)+CGFloat(Double.pi/2), clockwise: false) //reversed, but works
            ringShapePath.close()
        }
    
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
                renderShapes: true,
                ringShape: ringShapePath)
            
            //move it closer to center
            currentDistance = currentDistance - ringSetting.ringWidth
        }

    }
    
    func generateRingNode( _ clockFaceNode: SKShapeNode, patternTotal: Int, patternArray: [Int], ringType: RingTypes, material: String, currentDistance: Float, clockFaceSettings: ClockFaceSetting, ringSettings: ClockRingSetting, renderNumbers: Bool, renderShapes: Bool, ringShape: UIBezierPath ) {
        
        let ringNode = SKNode()
        ringNode.name = "ringNode"
        clockFaceNode.addChild(ringNode)
        
        //just exit for spacer
        if (ringType == RingTypes.RingTypeSpacer) { return }
        
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
            
            var outerRingNode = SKNode.init()
            
            //get new position
            let percentOfPath:CGFloat = CGFloat(outerRingIndex) / CGFloat(patternTotal)
            let distanceMult = CGFloat(currentDistance)
            guard let newPos = ringShape.point(at: percentOfPath) else { return }
            let scaledPoint = newPos.applying(CGAffineTransform.init(scaleX: distanceMult, y: distanceMult))
            
            if (renderNumbers && ringType == RingTypes.RingTypeTextNode || renderNumbers && ringType == RingTypes.RingTypeTextRotatingNode) {
                //print("patternDraw")
                
                //numbers
                var numberToRender = outerRingIndex
                if numberToRender == 0 { numberToRender = patternTotal }
                
                //force small totals to show as 12s
                if patternTotal < 12 {
                    numberToRender = numberToRender * ( 12 / patternTotal )
                }
                
                outerRingNode  = NumberTextNode.init(
                    numberTextType: ringSettings.textType,
                    textSize: ringSettings.textSize,
                    currentNum: numberToRender,
                    totalNum: patternTotal,
                    shouldDisplayRomanNumerals: clockFaceSettings.shouldShowRomanNumeralText,
                    pivotMode: 0, fillColor: SKColor.init(hexString: material))
                
                ringNode.name = "textRingNode"
                
                if ringType == .RingTypeTextRotatingNode {
                    let angle = atan2(scaledPoint.y, scaledPoint.x)
                    outerRingNode.zRotation = angle - CGFloat(Double.pi/2)
                }
                
            }
            if (ringType == RingTypes.RingTypeShapeNode) {
                //shape
                outerRingNode = FaceIndicatorNode.init(indicatorType:  ringSettings.indicatorType, size: ringSettings.indicatorSize, fillColor: SKColor.init(hexString: material))
                outerRingNode.name = "indicatorNode"
                
                let angle = atan2(scaledPoint.y, scaledPoint.x)
                outerRingNode.zRotation = angle + CGFloat(Double.pi/2)
            }

            outerRingNode.zPosition = 1
            outerRingNode.position = scaledPoint
            
            ringNode.addChild(outerRingNode)
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
        positionHands(sec: sec, min: min, hour: hour, force: false)
    }
    
    func positionHands( sec: CGFloat, min: CGFloat, hour: CGFloat, force: Bool ) {
        if let secondHand = self.childNode(withName: "secondHand") {
            let newZAngle = -1 * deg2rad(sec * 6)
            
            //movement jump each second
            if (secondHandMovement == .SecondHandMovementStep || force) {
                secondHand.zRotation = newZAngle
            }
            
            //movment smoothly rotate each second
            if (secondHandMovement == .SecondHandMovementSmooth && !force) {
                //debugPrint("smooth sec:" + sec.description + " zAngle: " +  secondHand.zRotation.description + " newAngle:" + newZAngle.description )
                secondHand.removeAllActions()
                if sec == 0 { secondHand.zRotation = deg2rad(6) } //fix to keep it from spinning back around
                
                let smoothSecondAction = SKAction.rotate(toAngle: newZAngle, duration: 0.99)
                secondHand.run(smoothSecondAction)
            }
            
            //movement to oscillate
            if (secondHandMovement == .SecondHandMovementOscillate && !force) {
                let stepUnderValue = CGFloat(0.05)
                let duration = 0.99
            
                secondHand.removeAllActions()
                if sec == 0 { secondHand.zRotation = deg2rad(6) } //fix to keep it from spinning back around
                
                let rotSecondAction1 = SKAction.rotate(toAngle: newZAngle+stepUnderValue, duration: duration/2)
                rotSecondAction1.timingMode = .easeIn
                let rotSecondAction2 = SKAction.rotate(toAngle: newZAngle, duration: duration/2)
                rotSecondAction2.timingMode = .easeOut
                
                secondHand.run( SKAction.sequence( [ rotSecondAction1, rotSecondAction2 ]) )
            }
            
            //movement to step over
            if (secondHandMovement == .SecondHandMovementStepOver && !force) {
                let stepOverValue = CGFloat(0.030)
                let duration = 0.5
                
                secondHand.removeAllActions()
                if sec == 0 { secondHand.zRotation = deg2rad(6) } //fix to keep it from spinning back around
                
                let rotSecondAction1 = SKAction.rotate(toAngle: newZAngle-stepOverValue, duration: duration/5)
                let rotSecondAction2 = SKAction.rotate(toAngle: newZAngle, duration: duration/2)
    
                secondHand.run( SKAction.sequence( [ rotSecondAction1, rotSecondAction2 ]) )
            }
        }
        if let minuteHand = self.childNode(withName: "minuteHand") {
            if (minuteHandMovement == .MinuteHandMovementStep) {
                minuteHand.zRotation = -1 * deg2rad(min * 6)
            }
            if (minuteHandMovement == .MinuteHandMovementSmooth) {
                minuteHand.zRotation = -1 * deg2rad((min + sec/60) * 6)
            }
        }
        if let hourHand = self.childNode(withName: "hourHand") {
            hourHand.zRotation = -1 * deg2rad(hour * 30 + min/2)
        }
    }
    
    func setToTime() {
        setToTime( force: false)
    }
    
    func setToTime( force: Bool ) {
        // Called before each frame is rendered
        let date = Date()
        let calendar = Calendar.current
        
        let hour = CGFloat(calendar.component(.hour, from: date))
        let minutes = CGFloat(calendar.component(.minute, from: date))
        let seconds = CGFloat(calendar.component(.second, from: date))
        
        positionHands(sec: seconds, min: minutes, hour: hour, force: force)
    }
    
    func setToScreenShotTime() {
        self.secondHandMovement = .SecondHandMovementStep
        positionHands(sec: AppUISettings.screenShotSeconds, min: AppUISettings.screenShotMinutes, hour: AppUISettings.screenShotHour)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
}
