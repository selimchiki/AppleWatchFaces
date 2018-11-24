//
//  FaceChooserTableViewController.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/18/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit

//used in the subclassed cells to override calling selection
class FaceChooserSelectableTableViewCell:UITableViewCell {
    func chooseSetting( animated: Bool ) {
        debugPrint("** generic faceSelection called, not overridden **")
    }
}

class FaceChooserTableViewController: UITableViewController {
    
    var faceChooserCollectionView : UICollectionView?
    
    //setting correct item on destination
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FaceChooserDetailSegueID" {
            //get currently selected
            if let currentFaceChooserCollectionView = faceChooserCollectionView, let indexPathForSelectedItems = currentFaceChooserCollectionView.indexPathsForSelectedItems {
                
                let selectedIndex = indexPathForSelectedItems.first!.item
                    //debugPrint("segue selected item: " + String(selectedIndex))
                if let settingsViewController = segue.destination as? SettingsViewController {
                    settingsViewController.currentClockIndex = selectedIndex
                }
            }
        }
    }
    
    //data sourse
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "faceChooserTabeViewCellID"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FaceChooserTableViewCell
        faceChooserCollectionView = cell.faceChooserCollectionView
        
        return cell
    }
    
    func reloadAllThumbs() {
        //may have new items, lets reload them
        if let fCv = faceChooserCollectionView {
            fCv.reloadData()
        }
    }
    
    func reloadVisibleThumbs() {
        //may have new items, lets reload them
        if let fCv = faceChooserCollectionView {
            fCv.reloadItems(at: fCv.indexPathsForVisibleItems)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //reloadVisibleThumbs()
    }
    
}
