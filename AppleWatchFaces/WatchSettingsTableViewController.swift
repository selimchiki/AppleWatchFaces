//
//  WatchSettingsTableViewController.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 10/29/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit
import Foundation

//used in the subclassed cells to override calling selection
class WatchSettingsSelectableTableViewCell:UITableViewCell {
    func chooseSetting( animated: Bool ) {
        debugPrint("** generic chooseSetting called, not overridden **")
    }
}

class WatchSettingsTableViewController: UITableViewController {
    
    static let settingsTableSectionReloadNotificationName = Notification.Name("settingsTableSectionReload")
    
    //header text,
    let sectionsData = [
        ["title":"Face Background Type",   "cellID":"faceBackgroundTypeTableViewCell"],
        ["title":"Face Background Color",   "cellID":"faceBackgroundColorsTableViewCell"],
        ["title":"Main Background Color",   "cellID":"mainBackgroundColorsTableViewCell"],
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
            case 0: settingText = FaceBackgroundNode.descriptionForType(SettingsViewController.currentClockSetting.faceBackgroundType)
            case 1: settingText = SettingsViewController.currentClockSetting.clockFaceMaterialName
            case 2: settingText = SettingsViewController.currentClockSetting.clockCasingMaterialName
            case 3: settingText = SecondHandNode.descriptionForType((SettingsViewController.currentClockSetting.clockFaceSettings?.secondHandType)!)
            case 4: settingText = SettingsViewController.currentClockSetting.clockFaceSettings?.secondHandMaterialName ?? ""
            case 5: settingText = MinuteHandNode.descriptionForType((SettingsViewController.currentClockSetting.clockFaceSettings?.minuteHandType)!)
            case 6: settingText = SettingsViewController.currentClockSetting.clockFaceSettings?.minuteHandMaterialName ?? ""
            case 7: settingText = HourHandNode.descriptionForType((SettingsViewController.currentClockSetting.clockFaceSettings?.hourHandType)!)
            case 8: settingText = SettingsViewController.currentClockSetting.clockFaceSettings?.hourHandMaterialName ?? ""
        
            default: settingText = ""
        }
        return settingText
    }
    
    func selectCurrentSettings(animated: Bool) {
        //loop through the cells and tell them to select their collectionView current item
        for sectionNum in 0 ... sectionsData.count {
            let indexPath = IndexPath.init(row: 0, section: sectionNum)
            
            //tell the header to update it value
            if let headerView = self.tableView.headerView(forSection: sectionNum) {
                if let headerCell = headerView as? SettingsTableHeaderViewCell {
                    headerCell.settingLabel.text = valueForHeader( section: sectionNum)
                }
            }
            //get the cell, tell is to select its current item ( knows its own type to be able to select it )
            if let currentcell = self.tableView.cellForRow(at: indexPath) as? WatchSettingsSelectableTableViewCell {
                currentcell.chooseSetting(animated: true)
            }
        
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        if let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SettingsTableHeaderViewID") as? SettingsTableHeaderViewCell {
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
        debugPrint("tableView full reload!!")
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SettingsTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SettingsTableHeaderViewID")
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(notification:)), name: WatchSettingsTableViewController.settingsTableSectionReloadNotificationName, object: nil)
    }
    
}

