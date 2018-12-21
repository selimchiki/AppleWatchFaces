//
//  FaceShapeSettingSettingsTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/28/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class FaceShapeSettingSettingsTableViewCell: WatchSettingsSelectableTableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var faceShapeSettingCollectionView: UICollectionView!
    
    //var selectedCellIndex:Int?
    
    // called after a new setting should be selected ( IE a new design is loaded )
    override func chooseSetting( animated: Bool ) {
        //debugPrint("** SecondHandSettingsTableViewCell called **")
        
        if let currentShape = SettingsViewController.currentClockSetting.clockFaceSettings?.ringRenderShape {
            if let shapeIndex = RingRenderShapes.userSelectableValues.firstIndex(of: currentShape) {
                let indexPath = IndexPath.init(row: shapeIndex, section: 0)

                //scroll and set native selection
                faceShapeSettingCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.right)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let renderShape = RingRenderShapes.userSelectableValues[indexPath.row]
        //debugPrint("selected cell SecondHandMovements: " + secondHandMovement.rawValue)

        //update the value
        SettingsViewController.currentClockSetting.clockFaceSettings?.ringRenderShape = renderShape
        NotificationCenter.default.post(name: SettingsViewController.settingsChangedNotificationName, object: nil, userInfo:nil)
        NotificationCenter.default.post(name: WatchSettingsTableViewController.settingsTableSectionReloadNotificationName, object: nil,
                                        userInfo:["cellId": self.cellId , "settingType":"ringRenderShape"])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RingRenderShapes.userSelectableValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingsFaceShapeCell", for: indexPath) as! FaceShapeSettingCollectionViewCell
        
        let shape = RingRenderShapes.userSelectableValues[indexPath.row]
        cell.title.text = ClockRingSetting.descriptionForRingRenderShapes(shape)
        
//        if secondHandMovement == .SecondHandMovementSmooth {
//            cell.thumbnail.image = UIImage.init(named: "secondhandAnimation-smooth.jpg")
//        }
//        if secondHandMovement == .SecondHandMovementStep {
//            cell.thumbnail.image = UIImage.init(named: "secondhandAnimation-step.jpg")
//        }
//        if secondHandMovement == .SecondHandMovementOscillate {
//            cell.thumbnail.image = UIImage.init(named: "secondhandAnimation-oscillate.jpg")
//        }
//        if secondHandMovement == .SecondHandMovementStepOver {
//            cell.thumbnail.image = UIImage.init(named: "secondhandAnimation-stepOver.jpg")
//        }
        
        return cell
    }
}

