//
//  SecondHandSettingsTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 10/29/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class MinuteHandSettingsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let selectedColor = SKColor.init(white: 0.5, alpha: 1.0)
    let deSelectedColor = SKColor.init(white: 0.0, alpha: 1.0)
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let minuteHandType = MinuteHandTypes.userSelectableValues[indexPath.row]
        debugPrint("selected cell minuteHandType: " + minuteHandType.rawValue)
        
        //update the value
        SettingsViewController.currentClockSetting.clockFaceSettings?.minuteHandType = minuteHandType
        NotificationCenter.default.post(name: SettingsViewController.settingsChangedNotificationName, object: nil, userInfo:nil)
        NotificationCenter.default.post(name: WatchSettingsTableViewController.settingsTableSectionReloadNotificationName, object: nil, userInfo:["settingType":"minuteHandType"])
        
        if let settingsHandCell = collectionView.cellForItem(at: indexPath) as? MinuteHandSettingCollectionViewCell {
            if let currentScene = settingsHandCell.skView.scene {
                currentScene.backgroundColor = selectedColor
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let minuteHandType = MinuteHandTypes.userSelectableValues[indexPath.row]
        debugPrint("deSelected cell minuteHandType: " + minuteHandType.rawValue)
        
        if let settingsHandCell = collectionView.cellForItem(at: indexPath) as? MinuteHandSettingCollectionViewCell {
            if let currentScene = settingsHandCell.skView.scene {
                currentScene.backgroundColor = deSelectedColor
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return MinuteHandTypes.userSelectableValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingsHandCell", for: indexPath) as! MinuteHandSettingCollectionViewCell
        
        let previewScene = SKScene.init()
        previewScene.scaleMode = .aspectFill
        
        //draw it selected
        if cell.isSelected {
            previewScene.backgroundColor = selectedColor
        }
        
        cell.minuteHandType = MinuteHandTypes.userSelectableValues[indexPath.row]
        
        let handNode = MinuteHandNode.init(minuteHandType: MinuteHandTypes.userSelectableValues[indexPath.row])
        handNode.setScale(0.005)
        handNode.position = CGPoint.init(x: previewScene.size.width/2, y: previewScene.size.width/10)
        previewScene.addChild(handNode)
        
        // Present the scene
        cell.skView.presentScene(previewScene)

        return cell
    }
    
    
}
