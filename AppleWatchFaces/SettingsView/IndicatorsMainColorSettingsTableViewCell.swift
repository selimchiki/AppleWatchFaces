//
//  IndicatorsMainColorSettingsTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 10/29/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class IndicatorsMainColorSettingsTableViewCell: ColorSettingsTableViewCell {
    
    @IBOutlet var indicatorsMainColorSettingsTableViewCell: UICollectionView!
    
    // called after a new setting should be selected ( IE a new design is loaded )
    override func chooseSetting( animated: Bool ) {
        //debugPrint("** SecondHandColorSettingsTableViewCell called **" + SettingsViewController.currentClockSetting.clockFaceSettings!.secondHandMaterialName)
        
        if let clockFaceSettings = SettingsViewController.currentClockSetting.clockFaceSettings {
            let filteredColor = colorListVersion(unfilteredColor: clockFaceSettings.ringMaterials[0])
            if let materialColorIndex = colorList.firstIndex(of: filteredColor) {
                let indexPath = IndexPath.init(row: materialColorIndex, section: 0)
                
                //scroll and set native selection
                indicatorsMainColorSettingsTableViewCell.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.right)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newColor = colorList[indexPath.row]
        debugPrint("selected cell ringMaterials[0]: " + newColor)
        
        //update the value
        SettingsViewController.currentClockSetting.clockFaceSettings?.ringMaterials[0] = newColor
        NotificationCenter.default.post(name: SettingsViewController.settingsChangedNotificationName, object: nil, userInfo:nil)
        NotificationCenter.default.post(name: WatchSettingsTableViewController.settingsTableSectionReloadNotificationName, object: nil, userInfo:["settingType":"clockFaceSettings.ringMaterials"])
    }
    
}
