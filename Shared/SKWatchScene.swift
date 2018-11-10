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
    
    static let sizeMulitplier:CGFloat = 100.0 //in pixels 
    
    func redraw(clockSetting: ClockSetting) {
        
//        if let titleLabel = self.childNode(withName: "titleLabel") as? SKLabelNode {
//            titleLabel.text = clockSetting.title
//        }
        
        let newWatchFaceNode = WatchFaceNode.init(clockSetting: clockSetting, size: self.size )
        newWatchFaceNode.setScale(1.45)
        
        if let oldNode = self.childNode(withName: "watchFaceNode") {
            oldNode.removeFromParent()
        }
        self.addChild(newWatchFaceNode)
    }
    
    override func sceneDidLoad() {
        redraw( clockSetting: ClockSetting.defaults() )
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let watchFaceNode = self.childNode(withName: "watchFaceNode") as? WatchFaceNode {
            watchFaceNode.setToTime()
        }
    }
    
    
}
