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
    
    //current selected group
    var currentGroupIndex = 0
    
    //header text,
    let sectionsData = [
        [
            ["title":"Title",                       "rowHeight":"66.0", "cellID":"titleSettingsTableViewCellID"],
            ["title":"Color Theme",                 "rowHeight":"130.0", "cellID":"colorThemeSettingsTableViewCellID"],
            ["title":"Items Theme",                 "rowHeight":"130.0","cellID":"decoratorThemeSettingsTableViewCellID"]
        ],
        [
            ["title":"Face Background Type",        "rowHeight":"100.0","cellID":"faceBackgroundTypeTableViewCell"],
            ["title":"Face Background Color",       "rowHeight":"100.0","cellID":"faceBackgroundColorsTableViewCell"],
            ["title":"Main Background Color",       "rowHeight":"100.0","cellID":"mainBackgroundColorsTableViewCell"]
        ],
        [
            ["title":"Hand Display",                "rowHeight":"66.0","cellID":"handsOptionsSettingsTableViewCellID"],
            ["title":"Second Hand",                 "rowHeight":"100.0","cellID":"secondHandSettingsTableViewCell"],
            ["title":"Second Hand Color",           "rowHeight":"100.0","cellID":"secondHandColorsTableViewCell"],
            ["title":"Minute Hand",                 "rowHeight":"100.0","cellID":"minuteHandSettingsTableViewCell"],
            ["title":"Minute Hand Color",           "rowHeight":"100.0","cellID":"minuteHandColorTableViewCell"],
            ["title":"Hour Hand",                   "rowHeight":"100.0","cellID":"hourHandSettingsTableViewCell"],
            ["title":"Hour Hand Color",             "rowHeight":"100.0","cellID":"hourHandColorTableViewCell"],
            ["title":"Hand Outline Color",          "rowHeight":"100.0","cellID":"handOutlineColorTableViewCell"]
        ],
        [
            ["title":"Indicator Parts",             "rowHeight":"100.0","cellID":"ringEditorTableViewCellID"],
            ["title":"Indicators Main Color",       "rowHeight":"100.0","cellID":"ringMainColorsTableViewCell"],
            ["title":"Indicators Secondary Color",  "rowHeight":"100.0","cellID":"ringSecondaryColorsTableViewCell"],
            ["title":"Indicators Highlight Color",  "rowHeight":"100.0","cellID":"ringThirdColorsTableViewCell"]
            
        ]
    ]
    
    func valueForHeader( section: Int) -> String {
        var settingText = ""
        
        //base this off of the cellID so the data can be dynamic / grouped
        let cellID = sectionsData[currentGroupIndex][section]["cellID"]
        
        switch cellID {
            
        case "titleSettingsTableViewCellID":
            settingText = SettingsViewController.currentClockSetting.title
        case "colorThemeSettingsTableViewCellID":
            settingText = SettingsViewController.currentClockSetting.themeTitle
        case "decoratorThemeSettingsTableViewCellID":
            settingText = SettingsViewController.currentClockSetting.decoratorThemeTitle
        
        case "faceBackgroundTypeTableViewCell":
            settingText = FaceBackgroundNode.descriptionForType(SettingsViewController.currentClockSetting.faceBackgroundType)
        case "faceBackgroundColorsTableViewCell":
            settingText = SettingsViewController.currentClockSetting.clockFaceMaterialName
        case "mainBackgroundColorsTableViewCell":
            settingText = SettingsViewController.currentClockSetting.clockCasingMaterialName
        case "handsOptionsSettingsTableViewCellID":
            let shouldShowHandOutlines = SettingsViewController.currentClockSetting.clockFaceSettings?.shouldShowHandOutlines
            if (shouldShowHandOutlines == true) {
                settingText = "show outlines"
            } else {
                settingText = "no outlines"
            }
        case "secondHandSettingsTableViewCell":
            settingText = SecondHandNode.descriptionForType((SettingsViewController.currentClockSetting.clockFaceSettings?.secondHandType)!)
        case "secondHandColorsTableViewCell":
            settingText = SettingsViewController.currentClockSetting.clockFaceSettings?.secondHandMaterialName ?? ""
        case "minuteHandSettingsTableViewCell":
            settingText = MinuteHandNode.descriptionForType((SettingsViewController.currentClockSetting.clockFaceSettings?.minuteHandType)!)
        case "minuteHandColorTableViewCell":
            settingText = SettingsViewController.currentClockSetting.clockFaceSettings?.minuteHandMaterialName ?? ""
        case "hourHandSettingsTableViewCell":
            settingText = HourHandNode.descriptionForType((SettingsViewController.currentClockSetting.clockFaceSettings?.hourHandType)!)
        case "hourHandColorTableViewCell":
            settingText = SettingsViewController.currentClockSetting.clockFaceSettings?.hourHandMaterialName ?? ""
        case "handOutlineColorTableViewCell":
            settingText = SettingsViewController.currentClockSetting.clockFaceSettings?.handOutlineMaterialName ?? ""
        case "ringMainColorsTableViewCell":
            settingText = SettingsViewController.currentClockSetting.clockFaceSettings?.ringMaterials[0] ?? ""
        case "ringSecondaryColorsTableViewCell":
            settingText = SettingsViewController.currentClockSetting.clockFaceSettings?.ringMaterials[1] ?? ""
        case "ringThirdColorsTableViewCell":
            if let clockFaceSettings = SettingsViewController.currentClockSetting.clockFaceSettings {
                if clockFaceSettings.ringMaterials.count>2 {
                settingText = clockFaceSettings.ringMaterials[2]
                }
                    
            }
        case "ringEditorTableViewCellID":
            settingText = String( SettingsViewController.currentClockSetting.clockFaceSettings!.ringSettings.count )
            
            default: settingText = ""
        }
        return settingText
    }
    
    func reloadAfterGroupChange() {
        self.tableView.reloadData()
        selectCurrentSettings(animated: false)
    }
    
    func selectCurrentSettings(animated: Bool) {
        //loop through the cells and tell them to select their collectionView current item
        for sectionNum in 0 ... sectionsData[currentGroupIndex].count {
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
        return sectionsData[currentGroupIndex].count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellId = sectionsData[currentGroupIndex][indexPath.section]["cellID"]!
        if cellId == "ringEditorTableViewCellID" {
            //call segue
            self.performSegue(withIdentifier: "callDecoratorPreviewSegueID", sender: nil)
            //
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight = sectionsData[currentGroupIndex][indexPath.section]["rowHeight"]!
        let doubleVal = Double.init(rowHeight)
        return CGFloat( doubleVal ?? 100.0 )
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
        return sectionsData[currentGroupIndex][section]["title"]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = sectionsData[currentGroupIndex][indexPath.section]["cellID"]!
        if cellId == "ringEditorTableViewCellID" {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DecoratorRingsSettingsTableViewCell
            
            let ringNum = String( SettingsViewController.currentClockSetting.clockFaceSettings!.ringSettings.count )
            cell.decoratorRingsLabel.text = ringNum + " parts make up this face"
            
            return cell
        } else {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            return cell
        }
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

