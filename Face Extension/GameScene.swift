//
//  GameScene.swift
//  Face Extension
//
//  Created by Michael Hill on 10/17/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    private var spinnyNode : SKShapeNode?
    
    func redraw() {
        
        let faceChosen = UserDefaults.standard.string(forKey: "FaceChosen") ?? "defaultFace"
        
        if let label = self.childNode(withName: "//helloLabel") as? SKLabelNode {
            label.text = faceChosen
        }
    }
    
    override func sceneDidLoad() {
        
        if let label = self.childNode(withName: "//helloLabel") as? SKLabelNode {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        redraw()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
