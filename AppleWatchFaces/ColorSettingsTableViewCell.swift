//
//  ColorSettingsTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/7/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit
import SpriteKit

class ColorSettingsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    let selectedColor = SKColor.init(white: 0.5, alpha: 1.0)
    let deSelectedColor = SKColor.init(white: 0.0, alpha: 1.0)
    
    public var colorList : [String] = []
    //    {
    //        didSet {
    //            self.reloadData()
    //        }
    // }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadColorList()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let settingsHandCell = collectionView.cellForItem(at: indexPath) {
            settingsHandCell.backgroundColor = deSelectedColor
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingsColorCell", for: indexPath) as! ColorSettingCollectionViewCell
        
        //draw it selected
        if cell.isSelected {
            cell.backgroundColor = selectedColor
        } else {
            cell.backgroundColor = deSelectedColor
        }
        
        cell.circleView.backgroundColor = SKColor.init(hexString: colorList[indexPath.row] )
        
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
