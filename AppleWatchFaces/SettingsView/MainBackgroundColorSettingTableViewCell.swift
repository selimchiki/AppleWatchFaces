//
//  MainBackgroundColorSettingTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/17/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class MainBackgroundColorSettingTableViewCell: ColorSettingsTableViewCell {
    
    @IBOutlet var mainBackgroundColorSelectionCollectionView: UICollectionView!
    
    //var selectedCellIndex:Int?
    
    // called after a new setting should be selected ( IE a new design is loaded )
    override func chooseSetting( animated: Bool ) {
        debugPrint("** MainBackgroundColorSettingTableViewCell called **" + SettingsViewController.currentClockSetting.clockCasingMaterialName)
        
        let filteredColor = colorListVersion(unfilteredColor: SettingsViewController.currentClockSetting.clockCasingMaterialName)
        if let materialColorIndex = colorList.firstIndex(of: filteredColor) {
            let indexPath = IndexPath.init(row: materialColorIndex, section: 0)
            
            //scroll and set native selection
            mainBackgroundColorSelectionCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.right)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newColor = colorList[indexPath.row]
        debugPrint("selected cell mainBackgroundColor: " + newColor)
        
        //update the value
        SettingsViewController.currentClockSetting.clockCasingMaterialName = newColor
        NotificationCenter.default.post(name: SettingsViewController.settingsChangedNotificationName, object: nil, userInfo:nil)
        NotificationCenter.default.post(name: WatchSettingsTableViewController.settingsTableSectionReloadNotificationName, object: nil, userInfo:["settingType":"clockCasingMaterialName"])
    }
    
}
