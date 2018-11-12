//
//  SecondHandSettingCollectionViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 10/29/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit
import SpriteKit

class SecondHandSettingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var skView : SKView!
    var secondHandType: SecondHandTypes = SecondHandTypes.SecondHandNodeTypeNone
    
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
