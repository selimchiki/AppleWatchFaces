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

class SecondHandColorSettingsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let selectedColor = SKColor.init(white: 0.5, alpha: 1.0)
    let deSelectedColor = SKColor.init(white: 0.0, alpha: 1.0)
    
    var colorList : [String] = []
//    {
//        didSet {
//            self.reloadData()
//        }
// }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadColorList()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newColor = colorList[indexPath.row]
        debugPrint("selected cell secondHandColor: " + newColor)

        //update the value
        SettingsViewController.currentClockSetting.clockFaceSettings?.secondHandMaterialName = newColor
        NotificationCenter.default.post(name: SettingsViewController.settingsChangedNotificationName, object: nil, userInfo:nil)
        NotificationCenter.default.post(name: WatchSettingsTableViewController.settingsTableSectionReloadNotificationName, object: nil, userInfo:["settingType":"secondHandColor"])
//
//        if let settingsHandCell = collectionView.cellForItem(at: indexPath) as? SecondHandSettingCollectionViewCell {
//            if let currentScene = settingsHandCell.skView.scene {
//                currentScene.backgroundColor = selectedColor
//            }
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return colorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingsColorCell", for: indexPath) as! ColorSettingCollectionViewCell
        
        //draw it selected
//        if cell.isSelected {
//            previewScene.backgroundColor = selectedColor
//        }
        
        cell.circleView.backgroundColor = SKColor.init(hexString: colorList[indexPath.row] )
        //cell.secondHandType = SecondHandTypes.userSelectableValues[indexPath.row]
        
        return cell
    }
    
    // MARK: - Utility functions
    
    // load colors from Colors.plist and save to colorList array.
    private func loadColorList() {
            // create path for Colors.plist resource file.
        let colorFilePath = Bundle.main.path(forResource: "Colors", ofType: "plist")
        
        // save piist file array content to NSArray object
        let colorNSArray = NSArray(contentsOfFile: colorFilePath!)
        
        // Cast NSArray to string array.
        colorList = colorNSArray as! [String]
    }
    
}
