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

class SecondHandSettingsTableViewCell: UITableViewCell, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return SecondHandTypes.userSelectableValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingsHandCell", for: indexPath) as! SecondHandSettingCollectionViewCell
        
        let previewScene = SKScene.init()
        previewScene.scaleMode = .aspectFill
        
        let handNode = SecondHandNode.init(secondHandType: SecondHandTypes.userSelectableValues[indexPath.row])
        handNode.position = CGPoint.init(x: previewScene.size.width/2, y: previewScene.size.width/10) 
        previewScene.addChild(handNode)
        
        // Present the scene
        cell.skView.presentScene(previewScene)

        return cell
    }
    
    
}
