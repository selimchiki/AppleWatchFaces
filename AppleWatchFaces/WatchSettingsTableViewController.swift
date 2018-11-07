//
//  WatchSettingsTableViewController.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 10/29/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit
import Foundation

class WatchSettingsTableViewController: UITableViewController {
    
    var objects = [Any]()

    static let settingsTableSectionReloadNotificationName = Notification.Name("settingsTableSectionReload")
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let headerCell = tableView.dequeueReusableCell(withIdentifier: "header") as? SettingsTableHeaderViewCell {
            headerCell.titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
            
            var settingText = ""
            switch section
            {
            case 0:
                settingText = SecondHandNode.descriptionForType((SettingsViewController.currentClockSetting.clockFaceSettings?.secondHandType)!)
            case 1:
                settingText = SettingsViewController.currentClockSetting.clockFaceSettings?.secondHandMaterialName ?? ""
            case 2:
                settingText = MinuteHandNode.descriptionForType((SettingsViewController.currentClockSetting.clockFaceSettings?.minuteHandType)!)
            case 3:
                settingText = HourHandNode.descriptionForType((SettingsViewController.currentClockSetting.clockFaceSettings?.hourHandType)!)
            default:
                settingText = ""
            }
            
            headerCell.settingLabel.text = settingText
            return headerCell
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch section
        {
        case 0:
            return "Second Hand"
        case 1:
            return "Second Hand Color"
        case 2:
            return "Minute Hand"
        case 3:
            return "Hour Hand"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellId = ""
        if indexPath.section == 0 { cellId = "secondHandSettingsTableViewCell" }
        if indexPath.section == 1 { cellId = "secondHandColorsTableViewCell" }
        if indexPath.section == 2 { cellId = "minuteHandSettingsTableViewCell" }
        if indexPath.section == 3 { cellId = "hourHandSettingsTableViewCell" }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            objects.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }
    
    @objc func onNotification(notification:Notification)
    {
        //TODO: tell correct section to reload
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(notification:)), name: WatchSettingsTableViewController.settingsTableSectionReloadNotificationName, object: nil)
    }
    
}

