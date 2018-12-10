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
    var shouldKeepTime:Bool = true
    static let sizeMulitplier:CGFloat = 100.0 //in pixels
    var currentSecond : Int = -1
    var secondHandTimer = Timer()
    
    func redraw(clockSetting: ClockSetting) {
        
        let newWatchFaceNode = WatchFaceNode.init(clockSetting: clockSetting, size: self.size )
        newWatchFaceNode.setScale(1.375)
        
        if let oldNode = self.childNode(withName: "watchFaceNode") {
            oldNode.removeFromParent()
        }
        
        if !shouldKeepTime {
            newWatchFaceNode.setToScreenShotTime()
        } else {
            newWatchFaceNode.setToTime( force: true )
        }
        self.addChild(newWatchFaceNode)
    }
    
    func stopTimeForScreenShot() {
        shouldKeepTime = false
        if let watchFaceNode = self.childNode(withName: "watchFaceNode") as? WatchFaceNode {
            watchFaceNode.setToScreenShotTime()
        }
    }
    
    func resumeTime() {
        shouldKeepTime = true
    }
    
    override func sceneDidLoad() {
        //redraw( clockSetting: ClockSetting.defaults() )
        startClockSecondHandTimer()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        //allow for no time update
        if !shouldKeepTime { return }
        
//        if let watchFaceNode = self.childNode(withName: "watchFaceNode") as? WatchFaceNode {
//            watchFaceNode.setToTime()
//        }
    }
    
    func startClockSecondHandTimer() {
        // if old action remove it
        stopClockSecondHandTimer()
        
        let duration = 0.1
        self.secondHandTimer = Timer.scheduledTimer( timeInterval: duration, target:self, selector: #selector(SKWatchScene.secondHandMovementCheck), userInfo: nil, repeats: true)
    }
    
    func stopClockSecondHandTimer() {
        if (self.secondHandTimer.isValid) {
            debugPrint("STOP second hand timer")
            self.secondHandTimer.invalidate()
        }
    }
    
    @objc func secondHandMovementCheck() {
        let date = Date()
        let calendar = Calendar.current
    
        let seconds = Int(calendar.component(.second, from: date))
        
        if (self.currentSecond != seconds) {
            secondHandMovementAction()
            self.currentSecond = seconds
        }
        
    }
    
    func secondHandMovementAction() {
        //debugPrint("second hand movement action")
        if let watchFaceNode = self.childNode(withName: "watchFaceNode") as? WatchFaceNode {
            watchFaceNode.setToTime()
        }
            
//            typedClockNode.setToTime(true, minuteHandMovement: self.currentClockSetting.clockFaceSettings?.minuteHandMovement, secondHandMovement: self.currentClockSetting.clockFaceSettings?.secondHandMovement)
    }
    
}
