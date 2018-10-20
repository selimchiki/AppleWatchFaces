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
    
    func redraw( labelText: String) {
        if let label = self.childNode(withName: "//helloLabel") as? SKLabelNode {
            label.text = labelText
        }
    }
    
    override func sceneDidLoad() {
        
        if let label = self.childNode(withName: "//helloLabel") as? SKLabelNode {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        let w = (self.size.width + self.size.height) * 0.05
        let spinnyNode = SKShapeNode(rectOf: CGSize(width: w, height: w), cornerRadius: w * 0.3)
        
        spinnyNode.position = CGPoint(x: 0.0, y: 0.0)
        spinnyNode.strokeColor = UIColor.red
        spinnyNode.lineWidth = 8.0
            
        spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                          SKAction.fadeOut(withDuration: 0.5),
                                          SKAction.removeFromParent()]))
        
        spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: 6.28, duration: 1)))
        
        self.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 2.0),
                                                           SKAction.run({
                                                            let n = spinnyNode.copy() as! SKShapeNode
                                                            self.addChild(n)
                                                           })])))
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
