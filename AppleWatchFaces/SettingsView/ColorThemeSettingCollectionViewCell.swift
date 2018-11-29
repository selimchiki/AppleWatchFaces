//
//  ColorThemeSettingCollectionViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/28/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit
import SpriteKit

class ColorThemeSettingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail : UIImageView!
    @IBOutlet weak var title : UILabel!
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                title.textColor = UIColor.init(hexString: AppUISettings.settingHighlightColor)
            } else {
                title.textColor = UIColor.init(hexString: "#FFFFFFFF")
            }
            
        }
    }
}

