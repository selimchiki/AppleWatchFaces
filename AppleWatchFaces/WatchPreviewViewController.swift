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

    var settingsViewController:SettingsViewController?
    @IBOutlet var skView: SKView!
    
    func stopTimeForScreenShot() {
        if let watchScene = skView.scene as? SKWatchScene {
            watchScene.stopTimeForScreenShot()
        }
    }
    
    func resumeTime() {
        if let watchScene = skView.scene as? SKWatchScene {
            watchScene.resumeTime()
        }
    }
    
    func makeThumb( imageName:String, cornerCrop: Bool ) -> Bool {
        //let newView = skView.snapshotView(afterScreenUpdates: true)
        if let newImage = skView?.snapshot {
            return newImage.save(imageName: imageName, cornerCrop: cornerCrop)
        } else {
            return false
        }
    }
    
    func redraw() {
        if let watchScene = skView.scene as? SKWatchScene {
            watchScene.redraw(clockSetting: SettingsViewController.currentClockSetting)
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if settingsViewController != nil {
        
                switch swipeGesture.direction {
                case UISwipeGestureRecognizer.Direction.right:
                    print("Swiped right")
                    settingsViewController?.prevClock()
                case UISwipeGestureRecognizer.Direction.left:
                    print("Swiped left")
                    settingsViewController?.nextClock()
                case UISwipeGestureRecognizer.Direction.up:
                    print("Swiped up")
                    settingsViewController?.sendSettingAction(sender: UIButton() )
                default:
                    break
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        skView.layer.cornerRadius = 28.0
        skView.layer.borderWidth = 4.0
        skView.layer.borderColor = SKColor.darkGray.cgColor
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(WatchPreviewViewController.respondToSwipeGesture(gesture:) ))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(WatchPreviewViewController.respondToSwipeGesture(gesture:) ))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(WatchPreviewViewController.respondToSwipeGesture(gesture:) ))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        
        // Load the SKScener
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
