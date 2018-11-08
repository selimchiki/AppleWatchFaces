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
    
    //header text,
    let sectionsData = [
        ["title":"Face Background Color",   "cellID":"faceBackgroundColorsTableViewCell"],
        ["title":"Second Hand",             "cellID":"secondHandSettingsTableViewCell"],
        ["title":"Second Hand Color",       "cellID":"secondHandColorsTableViewCell"],
        ["title":"Minute Hand",             "cellID":"minuteHandSettingsTableViewCell"],
        ["title":"Minute Hand Color",       "cellID":"minuteHandColorTableViewCell"],
        ["title":"Hour Hand",               "cellID":"hourHandSettingsTableViewCell"],
        ["title":"Hour Hand Color",         "cellID":"hourHandColorTableViewCell"],
    ]
    
    func valueForHeader( section: Int) -> String {
        var settingText = ""
        switch section {
            case 0: settingText = SettingsViewController.currentClockSetting.clockFaceMaterialName
            case 1: settingText = SecondHandNode.descriptionForType((SettingsViewController.currentClockSetting.clockFaceSettings?.secondHandType)!)
            case 2: settingText = SettingsViewController.currentClockSetting.clockFaceSettings?.secondHandMaterialName ?? ""
            case 3: settingText = MinuteHandNode.descriptionForType((SettingsViewController.currentClockSetting.clockFaceSettings?.minuteHandType)!)
            case 4: settingText = SettingsViewController.currentClockSetting.clockFaceSettings?.minuteHandMaterialName ?? ""
            case 5: settingText = HourHandNode.descriptionForType((SettingsViewController.currentClockSetting.clockFaceSettings?.hourHandType)!)
            case 6: settingText = SettingsViewController.currentClockSetting.clockFaceSettings?.hourHandMaterialName ?? ""
        
            default: settingText = ""
        }
        return settingText
    }
    
    static let settingsTableSectionReloadNotificationName = Notification.Name("settingsTableSectionReload")
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let headerCell = tableView.dequeueReusableCell(withIdentifier: "header") as? SettingsTableHeaderViewCell {
            headerCell.titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
            
            headerCell.settingLabel.text = valueForHeader( section: section)
            return headerCell
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return sectionsData[section]["title"]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = sectionsData[indexPath.section]["cellID"]!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        return cell
    }
    
    @objc func onNotification(notification:Notification)
    {
        //TODO: tell correct section to reload, type sent along
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(notification:)), name: WatchSettingsTableViewController.settingsTableSectionReloadNotificationName, object: nil)
    }
    
}

