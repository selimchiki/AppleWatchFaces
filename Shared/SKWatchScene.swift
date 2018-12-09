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
    
    func redraw(clockSetting: ClockSetting) {
        
        let newWatchFaceNode = WatchFaceNode.init(clockSetting: clockSetting, size: self.size )
        newWatchFaceNode.setScale(1.375)
        
        if let oldNode = self.childNode(withName: "watchFaceNode") {
            oldNode.removeFromParent()
        }
        
        if !shouldKeepTime { newWatchFaceNode.setToScreenShotTime() }
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
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        //allow for no time update
        if !shouldKeepTime { return }
        
        if let watchFaceNode = self.childNode(withName: "watchFaceNode") as? WatchFaceNode {
            watchFaceNode.setToTime()
        }
    }
    
    
}
