//
//  FaceChooserTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/18/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit

class FaceChooserTableViewCell: FaceChooserSelectableTableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var faceChooserCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("face chosen: " + String(indexPath.row))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserClockSetting.sharedClockSettings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "faceChooserCell", for: indexPath) as! FaceChooserCollectionViewCell
        
        let clockSetting = UserClockSetting.sharedClockSettings[indexPath.row]
        cell.title.text = clockSetting.title
        //debugPrint("U: " + clockSetting.title + " " + clockSetting.uniqueID)
        if let newImage = UIImage.getImageFor(imageName: clockSetting.uniqueID) {
            cell.imageView.image = newImage
            cell.imageView.layer.cornerRadius = AppUISettings.watchFrameCornerRadius
            cell.imageView.layer.borderColor = AppUISettings.watchFrameBorderColor
            cell.imageView.layer.borderWidth = AppUISettings.watchFrameBorderWidth
        } else {
            cell.imageView.image = nil
        }
        
        return cell
    }
    
}

