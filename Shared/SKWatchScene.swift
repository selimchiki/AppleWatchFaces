//
//  SKWatchScene.swift
//  Face Extension
//
//  Created by Michael Hill on 10/17/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import SpriteKit

class SKWatchScene: SKScene {
    
    private var spinnyNode : SKShapeNode?
    
    var secondHand:SKSpriteNode = SKSpriteNode()
    var minuteHand:SKSpriteNode = SKSpriteNode()
    var hourHand:SKSpriteNode = SKSpriteNode()
    
    func drawClockFace() {
        let faceNode = SKNode.init()
        faceNode.name = "faceNode"
        
        let screenWidth = self.size.width
        //let screenHeight = self.size.height
        
        let tickWidth:CGFloat = 3.0
        let tickHeight:CGFloat = 20.0
        let bufferWidth:CGFloat = 15.0
        
        for numberStep in 0...11 {
            let tickNode = SKShapeNode.init(rect: CGRect.init(x: 0, y: 0, width: tickWidth, height: tickHeight))
            tickNode.fillColor = SKColor.white
            tickNode.zRotation = deg2rad(90)
            
            let tickHolderNode = SKSpriteNode.init()
            tickHolderNode.addChild(tickNode)
            tickHolderNode.anchorPoint = CGPoint.init(x: 0, y: 0.5)
            tickNode.position = CGPoint.init(x: screenWidth/2 - tickWidth*2 - bufferWidth, y: 0)
            tickHolderNode.zRotation = deg2rad(CGFloat(numberStep) * 360/12)
            
            faceNode.addChild(tickHolderNode)
        }
        self.addChild(faceNode)
    }
    
    func redraw(clockSetting: ClockSetting) {
        
        let faceChosen = UserDefaults.standard.string(forKey: "FaceChosen") ?? "defaultFace"
        
        if let label = self.childNode(withName: "//helloLabel") as? SKLabelNode {
            label.text = faceChosen
        }
        
        if let clockFaceSettings = clockSetting.clockFaceSettings {
            let secHandNode = SecondHandNode.init(secondHandType: clockFaceSettings.secondHandType)
            secHandNode.name = "secondHand"
            secHandNode.zPosition = 1
            
            let minHandNode = MinuteHandNode.init(minuteHandType: clockFaceSettings.minuteHandType)
            minHandNode.name = "minuteHand"
            
            let hourHandNode = HourHandNode.init(hourHandType: clockFaceSettings.hourHandType)
            hourHandNode.name = "hourHand"
            
            //swap in new node
            if let secondHandParent = secondHand.parent {
                secondHandParent.addChild(secHandNode)
                secondHand.removeFromParent()
                
                //reset global for update later
                secondHand = secHandNode
            }
            
            if let minuteHandParent = minuteHand.parent {
                minuteHandParent.addChild(minHandNode)
                minuteHand.removeFromParent()
                
                //reset global for update later
                minuteHand = minHandNode
            }
            
            if let hourHandParent = hourHand.parent {
                hourHandParent.addChild(hourHandNode)
                hourHand.removeFromParent()
                
                //reset global for update later
                hourHand = hourHandNode
            }

        }
        
    }
    
    override func sceneDidLoad() {
        
        if let minHand:SKSpriteNode = self.childNode(withName: "minuteHand") as? SKSpriteNode{
            minuteHand = minHand
        }
        if let hrHand:SKSpriteNode = self.childNode(withName: "hourHand") as? SKSpriteNode{
            hourHand = hrHand
        }
        if let secHand:SKSpriteNode = self.childNode(withName: "secondHand") as? SKSpriteNode{
            secondHand = secHand
        }
        
        if let label = self.childNode(withName: "//helloLabel") as? SKLabelNode {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        drawClockFace()
        redraw( clockSetting: ClockSetting.defaults() )
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        let date = Date()
        let calendar = Calendar.current

        let hour = CGFloat(calendar.component(.hour, from: date))
        let minutes = CGFloat(calendar.component(.minute, from: date))
        let seconds = CGFloat(calendar.component(.second, from: date))
        
        secondHand.zRotation = -1 * deg2rad(seconds * 6)
        minuteHand.zRotation = -1 * deg2rad(minutes * 6)
        hourHand.zRotation = -1 * deg2rad(hour * 30 + minutes/2)
    }
    
    func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }

    
    
}
