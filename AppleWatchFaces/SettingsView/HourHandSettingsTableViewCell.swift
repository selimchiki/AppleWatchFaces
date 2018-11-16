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

class HourHandSettingsTableViewCell: WatchSettingsSelectableTableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var hourHandSelectionCollectionView: UICollectionView!
    
    // called after a new setting should be selected ( IE a new design is loaded )
    override func chooseSetting( animated: Bool ) {
        //debugPrint("** HourHandSettingsTableViewCell called **")
        
        if let currentHourHandType = SettingsViewController.currentClockSetting.clockFaceSettings?.hourHandType {
            if let hourHandTypeIndex = HourHandTypes.userSelectableValues.firstIndex(of: currentHourHandType) {
                let indexPath = IndexPath.init(row: hourHandTypeIndex, section: 0)
                
                //scroll and set native selection
                hourHandSelectionCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.right)
                
                //stupid hack to force selection after scroll
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
                    self.setCellSelection(indexPath: indexPath)
                })
            }
        }
    }
    
    func setCellSelection( indexPath: IndexPath ) {
        //select new one
        if let settingsHandCell = hourHandSelectionCollectionView.cellForItem(at: indexPath) as? HourHandSettingCollectionViewCell {
            if let scene = settingsHandCell.skView.scene, let selectedNode = scene.childNode(withName: "selectedNode") {
                //TODO: animate this
                selectedNode.isHidden = false
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hourHandType = HourHandTypes.userSelectableValues[indexPath.row]
        debugPrint("selected cell hourHandType: " + hourHandType.rawValue)
        
        //update the value
        SettingsViewController.currentClockSetting.clockFaceSettings?.hourHandType = hourHandType
        NotificationCenter.default.post(name: SettingsViewController.settingsChangedNotificationName, object: nil, userInfo:nil)
        NotificationCenter.default.post(name: WatchSettingsTableViewController.settingsTableSectionReloadNotificationName, object: nil, userInfo:["settingType":"hourHandType"])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return HourHandTypes.userSelectableValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingsHandCell", for: indexPath) as! HourHandSettingCollectionViewCell
        
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
            
            cell.hourHandType = HourHandTypes.userSelectableValues[indexPath.row]
            
            let scaleMultiplier:CGFloat = 0.005
            
            let handNode = HourHandNode.init(hourHandType: HourHandTypes.userSelectableValues[indexPath.row])
            handNode.setScale(scaleMultiplier)
            handNode.position = CGPoint.init(x: scene.size.width/2, y: scene.size.width/10)
            scene.addChild(handNode)
            
            let highlightColor = SKColor.init(hexString: AppUISettings.settingHighlightColor)
            let highlightLineWidth = AppUISettings.settingLineWidthBeforeScale
            let selectedHandNode = HourHandNode.init(hourHandType: HourHandTypes.userSelectableValues[indexPath.row], fillColor: SKColor.clear, strokeColor: highlightColor, lineWidth:highlightLineWidth)
            selectedHandNode.name = "selectedNode"
            selectedHandNode.setScale(scaleMultiplier)
            selectedHandNode.position = CGPoint.init(x: scene.size.width/2, y: scene.size.width/10)
            
            selectedHandNode.isHidden = !cell.isSelected
            
            scene.addChild(selectedHandNode)
        }

        return cell
    }
    
    
}
