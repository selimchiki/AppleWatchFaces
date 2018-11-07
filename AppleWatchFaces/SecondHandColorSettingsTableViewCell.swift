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

class SecondHandColorSettingsTableViewCell: ColorSettingsTableViewCell {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newColor = colorList[indexPath.row]
        debugPrint("selected cell secondHandColor: " + newColor)
        
        //update the value
        SettingsViewController.currentClockSetting.clockFaceSettings?.secondHandMaterialName = newColor
        NotificationCenter.default.post(name: SettingsViewController.settingsChangedNotificationName, object: nil, userInfo:nil)
        NotificationCenter.default.post(name: WatchSettingsTableViewController.settingsTableSectionReloadNotificationName, object: nil, userInfo:["settingType":"secondHandColor"])

        if let settingsHandCell = collectionView.cellForItem(at: indexPath) {
            settingsHandCell.backgroundColor = selectedColor
        }
    }
    
}
