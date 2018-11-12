//
//  HourHandSettingCollectionViewCell
//  AppleWatchFaces
//
//  Created by Michael Hill on 10/29/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit
import SpriteKit

class HourHandSettingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var skView : SKView!
    var hourHandType: HourHandTypes = HourHandTypes.HourHandTypeSwiss
    
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
