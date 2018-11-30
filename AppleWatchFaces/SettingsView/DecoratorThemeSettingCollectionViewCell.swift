//
//  DecoratorThemeSettingCollectionViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/28/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit
import SpriteKit

class DecoratorThemeSettingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail : UIImageView!
    @IBOutlet weak var title : UILabel!
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                title.textColor = UIColor.init(hexString: AppUISettings.settingHighlightColor)
                thumbnail.layer.borderWidth = AppUISettings.settingLineWidthBeforeScale
                thumbnail.layer.borderColor = UIColor.init(hexString: AppUISettings.settingHighlightColor ).cgColor
            } else {
                title.textColor = UIColor.init(hexString: "#FFFFFFFF")
                thumbnail.layer.borderWidth = 0.0
            }
            
        }
    }
}

