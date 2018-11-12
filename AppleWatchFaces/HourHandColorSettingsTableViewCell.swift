
//  HourHandColorSettingsTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 10/29/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class HourHandColorSettingsTableViewCell: ColorSettingsTableViewCell {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newColor = colorList[indexPath.row]
        debugPrint("selected cell hourHandColor: " + newColor)
        
        //update the value
        SettingsViewController.currentClockSetting.clockFaceSettings?.hourHandMaterialName = newColor
        NotificationCenter.default.post(name: SettingsViewController.settingsChangedNotificationName, object: nil, userInfo:nil)
        NotificationCenter.default.post(name: WatchSettingsTableViewController.settingsTableSectionReloadNotificationName, object: nil, userInfo:["settingType":"hourHandMaterialName"])
    }
    
}
