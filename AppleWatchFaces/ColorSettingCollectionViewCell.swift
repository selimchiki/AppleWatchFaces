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
    
//    @IBInspectable var borderWidth: CGFloat = 0 {
//        didSet {
//            layer.borderWidth = borderWidth
//        }
//    }
//    //Normal state bg and border
//    @IBInspectable var normalBorderColor: UIColor? {
//        didSet {
//            layer.borderColor = normalBorderColor?.cgColor
//        }
//    }
//
//    @IBInspectable var normalBackgroundColor: UIColor? {
//        didSet {
//            setBgColorForState(color: normalBackgroundColor, forState: .normal)
//        }
//    }
//
//
//    //Highlighted state bg and border
//    @IBInspectable var highlightedBorderColor: UIColor?
//
//    @IBInspectable var highlightedBackgroundColor: UIColor? {
//        didSet {
//            setBgColorForState(color: highlightedBackgroundColor, forState: .highlighted)
//        }
//    }
//
//
//    private func setBgColorForState(color: UIColor?, forState: UIControl.State){
//        if color != nil {
//            self.layer.backgroundColor = color?.cgColor
//        }
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleView.layer.cornerRadius = circleView.layer.frame.height / 2
        circleView.layer.borderWidth = 2.0
        circleView.layer.borderColor = SKColor.white.cgColor
        
        clipsToBounds = true
        
//        if borderWidth > 0 {
//                layer.borderColor = normalBorderColor?.cgColor
//        }
    }
}
