//
//  MinuteHandSettingsTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 10/29/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class MinuteHandSettingsTableViewCell: WatchSettingsSelectableTableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var minuteHandSelectionCollectionView: UICollectionView!
    
    // called after a new setting should be selected ( IE a new design is loaded )
    override func chooseSetting( animated: Bool ) {
        //debugPrint("** MinuteHandSettingsTableViewCell called **")
        
        if let currentMinuteHandType = SettingsViewController.currentClockSetting.clockFaceSettings?.minuteHandType {
            if let minuteHandTypeIndex = MinuteHandTypes.userSelectableValues.firstIndex(of: currentMinuteHandType) {
                let indexPath = IndexPath.init(row: minuteHandTypeIndex, section: 0)
                
                //scroll and set native selection
                minuteHandSelectionCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.right)
                
                //stupid hack to force selection after scroll
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
                    self.setCellSelection(indexPath: indexPath)
                })
            }
        }
    }
    
    func setCellSelection( indexPath: IndexPath ) {
        //select new one
        if let settingsHandCell = minuteHandSelectionCollectionView.cellForItem(at: indexPath) as? MinuteHandSettingCollectionViewCell {
            if let scene = settingsHandCell.skView.scene, let selectedNode = scene.childNode(withName: "selectedNode") {
                //TODO: animate this
                selectedNode.isHidden = false
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let minuteHandType = MinuteHandTypes.userSelectableValues[indexPath.row]
        debugPrint("selected cell minuteHandType: " + minuteHandType.rawValue)
        
        //update the value
        SettingsViewController.currentClockSetting.clockFaceSettings?.minuteHandType = minuteHandType
        NotificationCenter.default.post(name: SettingsViewController.settingsChangedNotificationName, object: nil, userInfo:nil)
        NotificationCenter.default.post(name: WatchSettingsTableViewController.settingsTableSectionReloadNotificationName, object: nil, userInfo:["settingType":"minuteHandType"])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let minuteHandType = MinuteHandTypes.userSelectableValues[indexPath.row]
        debugPrint("deSelected cell minuteHandType: " + minuteHandType.rawValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return MinuteHandTypes.userSelectableValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingsHandCell", for: indexPath) as! MinuteHandSettingCollectionViewCell
        
        if cell.skView.scene == nil  {
            //first run. create a new scene
            let previewScene = SKScene.init()
            previewScene.scaleMode = .aspectFill
            
            // Present the scene
            cell.skView.presentScene(previewScene)
        }
        
        if let scene = cell.skView.scene {
            //debugPrint("old scene")
            scene.removeAllChildren()
            
            cell.minuteHandType = MinuteHandTypes.userSelectableValues[indexPath.row]
            
            let scaleMultiplier:CGFloat = 0.005
            
            let handNode = MinuteHandNode.init(minuteHandType: MinuteHandTypes.userSelectableValues[indexPath.row])
            handNode.setScale(scaleMultiplier)
            handNode.position = CGPoint.init(x: scene.size.width/2, y: scene.size.width/10)
            scene.addChild(handNode)
            
            let highlightColor = SKColor.init(hexString: AppUISettings.settingHighlightColor)
            let highlightLineWidth = AppUISettings.settingLineWidthBeforeScale
            let selectedHandNode = MinuteHandNode.init(minuteHandType: MinuteHandTypes.userSelectableValues[indexPath.row], fillColor: SKColor.clear, strokeColor: highlightColor, lineWidth:highlightLineWidth)
            selectedHandNode.name = "selectedNode"
            selectedHandNode.setScale(scaleMultiplier)
            selectedHandNode.position = CGPoint.init(x: scene.size.width/2, y: scene.size.width/10)
            
            selectedHandNode.isHidden = !cell.isSelected
            
            scene.addChild(selectedHandNode)
        }

        return cell
    }
    
    
}
