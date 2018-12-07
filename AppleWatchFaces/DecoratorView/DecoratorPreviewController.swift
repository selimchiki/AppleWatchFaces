//
//  DecoratorPreviewController.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 12/2/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit
import SpriteKit

class DecoratorPreviewController: UIViewController {

    @IBOutlet var skView: SKView!
    var decoratorsTableViewController: DecoratorsTableViewController?
    static let ringSettingsChangedNotificationName = Notification.Name("ringSettingsChanged")
    
    func redraw(clockSetting: ClockSetting) {
        
        self.title = "Editing " + String( clockSetting.clockFaceSettings!.ringSettings.count ) + " parts"
        
        let newWatchFaceNode = WatchFaceNode.init(clockSetting: clockSetting, size: CGSize.init(width: 100, height: 100) )
        
        //TODO: figure out whay this is needed
        newWatchFaceNode.position = CGPoint.init(x: 0.5, y: 0.5)
        newWatchFaceNode.setScale(0.00375)
        newWatchFaceNode.hideHands()
        
        if let scene = skView.scene {
            if let oldNode = scene.childNode(withName: "watchFaceNode") {
                oldNode.removeFromParent()
            }
            scene.addChild(newWatchFaceNode)
        }
        
    }
    
    @objc func onNotification(notification:Notification)
    {
        //update values
        if let data = notification.userInfo as? [String: String] {
            if data["settingType"] == "sliderValue" {
                //do conditional drawing if needed
            }
        }
        
        redraw(clockSetting: SettingsViewController.currentClockSetting)
    }
    
    func addNewItem( ringType: RingTypes) {
        
        let newItem = ClockRingSetting.defaults()
        newItem.ringType = ringType
        SettingsViewController.currentClockSetting.clockFaceSettings!.ringSettings.append(newItem)
        redraw(clockSetting: SettingsViewController.currentClockSetting)
        
        if let dtVC = decoratorsTableViewController {
            dtVC.addNewItem(ringType: ringType)
        }
        
    }
    
    @objc func newItem() {
        let optionMenu = UIAlertController(title: nil, message: "New Indicator Item", preferredStyle: .actionSheet)
        
        for ringType in RingTypes.userSelectableValues {
            let newActionDescription = ClockRingSetting.descriptionForRingType(ringType)
            let newAction = UIAlertAction(title: newActionDescription, style: .default, handler: { action in
                self.addNewItem(ringType: ringType)
            } )
            optionMenu.addAction(newAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
        
//        decoratorsTableViewController.newItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let createButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.compose, target: self, action: #selector(newItem))
        self.navigationItem.rightBarButtonItems = [createButton]
        
        //round the preview watch SKView
        skView.layer.cornerRadius = 28.0
        skView.layer.borderWidth = 4.0
        skView.layer.borderColor = SKColor.darkGray.cgColor
        
        let scene = SKScene.init()
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        // Present the scene
        skView.presentScene(scene)
        
        redraw(clockSetting: SettingsViewController.currentClockSetting)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(notification:)), name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DecoratorsTableViewController {
            decoratorsTableViewController = segue.destination as? DecoratorsTableViewController
            decoratorsTableViewController!.decoratorPreviewController = self
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
