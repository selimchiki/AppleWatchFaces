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
            let background = SKShapeNode.init(circleOfRadius: 150.0)
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
            
            //draw the rings
            let tickWidth:CGFloat = 3.0
            let tickHeight:CGFloat = 20.0
            let bufferWidth:CGFloat = 15.0
            
            let faceNode = SKNode.init()
            faceNode.name = "faceNode"
            
            for numberStep in 0...11 {
                let tickNode = SKShapeNode.init(rect: CGRect.init(x: 0, y: 0, width: tickWidth, height: tickHeight))
                tickNode.fillColor = SKColor.white
                tickNode.zRotation = deg2rad(90)
                
                let tickHolderNode = SKSpriteNode.init()
                tickHolderNode.addChild(tickNode)
                tickHolderNode.anchorPoint = CGPoint.init(x: 0, y: 0.5)
                tickNode.position = CGPoint.init(x: size.width/2 - tickWidth*2 - bufferWidth, y: 0)
                tickHolderNode.zRotation = deg2rad(CGFloat(numberStep) * 360/12)
                
                faceNode.addChild(tickHolderNode)
            }
            
            self.addChild(faceNode)
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
