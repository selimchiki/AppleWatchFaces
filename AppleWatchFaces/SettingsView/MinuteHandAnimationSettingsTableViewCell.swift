//
//  MinuteHandAnimationSettingsTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/28/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class MinuteHandAnimationSettingsTableViewCell: WatchSettingsSelectableTableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var minuteHandAnimationCollectionView: UICollectionView!
    
    //var selectedCellIndex:Int?
    
    // called after a new setting should be selected ( IE a new design is loaded )
    override func chooseSetting( animated: Bool ) {
        
        if let currentMinuteHandMovement = SettingsViewController.currentClockSetting.clockFaceSettings?.minuteHandMovement {
            if let minuteHandMovementIndex = MinuteHandMovements.userSelectableValues.firstIndex(of: currentMinuteHandMovement) {
                let indexPath = IndexPath.init(row: minuteHandMovementIndex, section: 0)
                
                //scroll and set native selection
                minuteHandAnimationCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.right)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let minuteHandMovement = MinuteHandMovements.userSelectableValues[indexPath.row]
        
        //update the value
        SettingsViewController.currentClockSetting.clockFaceSettings?.minuteHandMovement = minuteHandMovement
        NotificationCenter.default.post(name: SettingsViewController.settingsChangedNotificationName, object: nil, userInfo:nil)
        NotificationCenter.default.post(name: WatchSettingsTableViewController.settingsTableSectionReloadNotificationName, object: nil,
                                        userInfo:["cellId": self.cellId , "settingType":"minuteHandMovement"])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MinuteHandMovements.userSelectableValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingsHandAnimationCell", for: indexPath) as! MinuteHandAnimationSettingCollectionViewCell
        
        let minuteHandMovement = MinuteHandMovements.userSelectableValues[indexPath.row]
        cell.title.text = MinuteHandNode.descriptionForMovement(minuteHandMovement)
        
        return cell
    }
}

