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
    var editBarButton: UIBarButtonItem = UIBarButtonItem()
    var decoratorsTableViewController: DecoratorsTableViewController?
    
    static let ringSettingsChangedNotificationName = Notification.Name("ringSettingsChanged")
    static let ringSettingsEditDetailNotificationName = Notification.Name("ringSettingsEditDetail")
    
    func highlightRing( ringNumber: Int) {
        guard let scene = skView.scene else { return }
        guard let watchFaceNode = scene.childNode(withName: "watchFaceNode") else { return }
    
        var ringChildren:[SKNode] = []
        for childnode in watchFaceNode.children {
            
            if childnode.name == "ringNode" || childnode.name == "textRingNode" {
                debugPrint("ringNode!" + (childnode.name ?? "") )
                ringChildren.append(childnode)
            }
        }
        
        guard let ringNode = ringChildren[safe: ringNumber] else { return }
        
        for childNode in ringNode.children {
            let bloomUpAction = SKAction.scale(to: 1.5, duration: 0.25)
            bloomUpAction.timingMode = .easeIn
            let bloomDownAction = SKAction.scale(to: 1.0, duration: 0.125)
            bloomUpAction.timingMode = .easeOut
            let combinedAction = SKAction.sequence([bloomUpAction, bloomDownAction])
            
            if ringNode.name == "ringNode" {
                if let indicatorNode = childNode.childNode(withName: "indicatorNode" ) {
                    indicatorNode.run(combinedAction)
                }
            } else {
                childNode.run(combinedAction)
            }
        }
        
    }
    
    func redraw(clockSetting: ClockSetting) {
        
        self.title = String( clockSetting.clockFaceSettings!.ringSettings.count ) + " parts"
        
        let newWatchFaceNode = WatchFaceNode.init(clockSetting: clockSetting, size: CGSize.init(width: 100, height: 100) )
        
        //TODO: figure out whay this is needed
        newWatchFaceNode.position = CGPoint.init(x: 0.5, y: 0.5)
        newWatchFaceNode.setScale(0.0035)
        newWatchFaceNode.hideHands()
        
        if let scene = skView.scene {
            if let oldNode = scene.childNode(withName: "watchFaceNode") {
                oldNode.removeFromParent()
            }
            scene.addChild(newWatchFaceNode)
        }
        
    }
    
    @objc func onSettingChangedNotification(notification:Notification)
    {
        //update values
        if let data = notification.userInfo as? [String: String] {
            if data["settingType"] == "sliderValue" {
                //do conditional drawing if needed
            }
        }
        
        redraw(clockSetting: SettingsViewController.currentClockSetting)
    }
    
    @objc func onSettingEditDetailNotification(notification:Notification)
    {
        
        if let settingType = notification.userInfo?["settingType"] as? String, settingType == "indicatorType", let decoratorShapeTableViewCell = notification.userInfo?["decoratorShapeTableViewCell"] as? DecoratorShapeTableViewCell  {
            
            let optionMenu = UIAlertController(title: nil, message: "Choose Shape", preferredStyle: .actionSheet)
            optionMenu.view.tintColor = UIColor.black
            
            for shapeType in FaceIndicatorTypes.userSelectableValues {
                let newAction = UIAlertAction(title: FaceIndicatorNode.descriptionForType(shapeType), style: .default, handler: { action in
                    decoratorShapeTableViewCell.shapeChosen(shapeType: shapeType)
                } )
                optionMenu.addAction(newAction)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            optionMenu.addAction(cancelAction)
            
            self.present(optionMenu, animated: true, completion: nil)
            
        }
        
        if let settingType = notification.userInfo?["settingType"] as? String, settingType == "textType", let decoratorTextTableViewCell = notification.userInfo?["decoratorTextTableViewCell"] as? DecoratorTextTableViewCell  {
            
                let optionMenu = UIAlertController(title: nil, message: "Choose Font", preferredStyle: .actionSheet)
                optionMenu.view.tintColor = UIColor.black
                
                for textType in NumberTextTypes.userSelectableValues {
                    let newAction = UIAlertAction(title: NumberTextNode.descriptionForType(textType), style: .default, handler: { action in
                        decoratorTextTableViewCell.fontChosen(textType: textType)
                    } )
                    optionMenu.addAction(newAction)
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                optionMenu.addAction(cancelAction)
                
                self.present(optionMenu, animated: true, completion: nil)
        }
        
        
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
        optionMenu.view.tintColor = UIColor.black
        
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
        
        if let dtVC = decoratorsTableViewController {
            dtVC.editButtonItem.tintColor = UIColor.orange
            createButton.tintColor = UIColor.orange
            self.navigationItem.rightBarButtonItems = [dtVC.editButtonItem, createButton]
        }
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(onSettingChangedNotification(notification:)), name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onSettingEditDetailNotification(notification:)), name: DecoratorPreviewController.ringSettingsEditDetailNotificationName, object: nil)
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
