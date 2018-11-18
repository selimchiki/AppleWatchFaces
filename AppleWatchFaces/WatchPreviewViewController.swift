//
//  WatchPreviewViewController.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 10/28/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import Foundation
import SpriteKit

class WatchPreviewViewController: UIViewController {

    @IBOutlet var skView: SKView!
    
    func redraw() {
        if let watchScene = skView.scene as? SKWatchScene {
            watchScene.redraw(clockSetting: SettingsViewController.currentClockSetting)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Load the SKScene
        if let scene = SKWatchScene(fileNamed: "SKWatchScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            skView.presentScene(scene)
        }
        
        //debug options
        skView.showsFPS = false
        skView.showsNodeCount = false
    }

}
