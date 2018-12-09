//
//  DecoratorThemeSettingsTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/28/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class DecoratorThemeSettingsTableViewCell: WatchSettingsSelectableTableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var decoratorThemeSelectionCollectionView: UICollectionView!
    
    // called after a new setting should be selected ( IE a new design is loaded )
    override func chooseSetting( animated: Bool ) {
        //TODO: select the theme based on title?
    }
    
    func setCellSelection( indexPath: IndexPath ) {
        //select new one
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let theme =  UserClockSetting.sharedDecoratorThemeSettings[indexPath.row]
        debugPrint("selected decorator theme: " + theme.title)
        
        //update the value
        SettingsViewController.currentClockSetting.applyDecoratorTheme(theme)
        SettingsViewController.currentClockSetting.decoratorThemeTitle = theme.title
        
        NotificationCenter.default.post(name: SettingsViewController.settingsChangedNotificationName, object: nil, userInfo:nil)
        NotificationCenter.default.post(name: WatchSettingsTableViewController.settingsTableSectionReloadNotificationName, object: nil,
                                        userInfo:["cellId": self.cellId , "settingType":"decoratorTheme"])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserClockSetting.sharedDecoratorThemeSettings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingsDecoratorThemeCell", for: indexPath) as! DecoratorThemeSettingCollectionViewCell
        
        let theme = UserClockSetting.sharedDecoratorThemeSettings[indexPath.row]
        cell.thumbnail.image = UIImage.init(named: theme.filename() + ".jpg")
        cell.thumbnail.layer.cornerRadius = AppUISettings.cornerRadiusForSettingsThumbs
        cell.title.text = theme.title
        
        return cell
    }
    
    
}

