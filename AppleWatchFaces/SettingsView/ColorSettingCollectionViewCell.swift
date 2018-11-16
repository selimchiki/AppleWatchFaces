//
//  ColorSettingCollectionViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/4/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit
import SpriteKit

//@IBDesignable
class ColorSettingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var circleView: UIView!
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            if let circleView = circleView {
                circleView.layer.borderWidth = borderWidth
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                circleView.layer.borderWidth = 2.0
                circleView.layer.borderColor = SKColor.init(hexString: AppUISettings.settingHighlightColor).cgColor
            }
            else {
                circleView.layer.borderWidth = 0.0
                circleView.layer.borderColor = SKColor.clear.cgColor
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleView.layer.cornerRadius = circleView.layer.frame.height / 2
        circleView.layer.borderWidth = 0.0
        circleView.layer.borderColor = SKColor.clear.cgColor
        
        clipsToBounds = true
        
//        if borderWidth > 0 {
//                layer.borderColor = normalBorderColor?.cgColor
//        }
    }
}
