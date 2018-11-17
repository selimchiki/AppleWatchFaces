//
//  FaceBackgroundSettingCollectionViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/17/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit
import SpriteKit

class FaceBackgroundSettingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var skView : SKView!
    var faceBackgroundType: FaceBackgroundTypes = FaceBackgroundTypes.FaceBackgroundTypeFilled
    
    override var isSelected: Bool {
        didSet {
            if let scene = skView.scene, let selectedNode = scene.childNode(withName: "selectedNode") {
                
                if self.isSelected {
                    selectedNode.isHidden = false
                }
                else {
                    selectedNode.isHidden = true
                }
                
            }
            
        }
    }
    
}

