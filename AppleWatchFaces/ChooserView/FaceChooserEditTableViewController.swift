//
//  FaceChooserEditTableViewController.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/18/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit

class FaceChooserEditTableViewController: UITableViewController {
    
    var faceChooserViewController: FaceChooserViewController?
    
    @IBAction func exit() {
        if let fcVC = self.faceChooserViewController {
            fcVC.faceListReloadType = .full
        }
        self.dismiss(animated: true) {
            
        }
    }
    
    //data sourse
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserClockSetting.sharedClockSettings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "faceChooserEditTableViewCellID"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FaceChooserEditTableViewCell
        
        let clockSetting = UserClockSetting.sharedClockSettings[indexPath.row]
        cell.title.text = clockSetting.title
        //debugPrint("U: " + clockSetting.title + " " + clockSetting.uniqueID)
        if let newImage = UIImage.getImageFor(imageName: clockSetting.uniqueID) {
            cell.thumbImageView.image = newImage
        } else {
            cell.thumbImageView.image = nil
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let sourceRow = sourceIndexPath.row;
        let destRow = destinationIndexPath.row;
        let object = UserClockSetting.sharedClockSettings[sourceRow]
        UserClockSetting.sharedClockSettings.remove(at: sourceRow)
        UserClockSetting.sharedClockSettings.insert(object, at: destRow)
        //save new result to disk
        UserClockSetting.saveToFile()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let sourceRow = indexPath.row;
            let trashedSetting = UserClockSetting.sharedClockSettings[sourceRow]
            //delete thumbnail
            if UIImage.delete(imageName:  trashedSetting.uniqueID) {
                UserClockSetting.sharedClockSettings.remove(at: sourceRow)
                tableView.deleteRows(at: [indexPath], with: .fade)
                setTitleWithCount()
                //save new result to disk
                UserClockSetting.saveToFile()
            }
        }
    }
    
    func setTitleWithCount() {
        self.navigationItem.title = "My Faces (" + String(UserClockSetting.sharedClockSettings.count) + ")"
    }
 
    override func viewDidLoad() {
        self.tableView.isEditing = true
        setTitleWithCount()
    }
    
}

