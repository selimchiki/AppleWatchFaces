//
//  DecoratorsTableViewController.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 12/2/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit

class DecoratorsTableViewController: UITableViewController {

    var decoratorPreviewController: DecoratorPreviewController?
    
    func addNewItem( ringType: RingTypes) {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: SettingsViewController.currentClockSetting.clockFaceSettings!.ringSettings.count-1, section: 0)], with: .automatic)
        self.tableView.endUpdates()
    }
    
    func redrawPreview() {
        //tell clock previe to redraw!
        if let dPreviewVC = decoratorPreviewController {
            dPreviewVC.redraw(clockSetting: SettingsViewController.currentClockSetting)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //important only select one at a time
        self.tableView.allowsMultipleSelection = false
        
        //self.tableView.isEditing = true
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if !tableView.isEditing {
            return .none
        } else {
            return .delete
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsViewController.currentClockSetting.clockFaceSettings!.ringSettings.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.isEditing {
            return 38.0
        } else {
            if let clockSettings = SettingsViewController.currentClockSetting.clockFaceSettings {
                let ringSetting = clockSettings.ringSettings[indexPath.row]
                
                if (ringSetting.ringType == .RingTypeTextNode || ringSetting.ringType == .RingTypeTextRotatingNode) {
                    return 230.0
                }
                
                if (ringSetting.ringType == .RingTypeShapeNode) {
                    return 180.0
                }
                
                if (ringSetting.ringType == .RingTypeSpacer) {
                    return 80.0
                }
            }
        }
        return 100.0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = DecoratorTableViewCell()
        
        if let clockSettings = SettingsViewController.currentClockSetting.clockFaceSettings {
            let ringSetting = clockSettings.ringSettings[indexPath.row]
            
            if (ringSetting.ringType == .RingTypeSpacer) {
                cell = tableView.dequeueReusableCell(withIdentifier: "decoratorEditorSpacerID", for: indexPath) as! DecoratorSpacerTableViewCell
            }
        
            if (ringSetting.ringType == .RingTypeShapeNode) {
                cell = tableView.dequeueReusableCell(withIdentifier: "decoratorEditorShapeID", for: indexPath) as! DecoratorShapeTableViewCell
            }
            
            if (ringSetting.ringType == .RingTypeTextNode || ringSetting.ringType == .RingTypeTextRotatingNode) {
                cell = tableView.dequeueReusableCell(withIdentifier: "decoratorEditorTextID", for: indexPath) as! DecoratorTextTableViewCell
            }
            
            cell.setupUIForClockRingSetting(clockRingSetting: ringSetting)
        }
        
        cell.parentTableview = self.tableView
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let sourceRow = sourceIndexPath.row;
        let destRow = destinationIndexPath.row;
        
        if nil != SettingsViewController.currentClockSetting.clockFaceSettings {
            let object = SettingsViewController.currentClockSetting.clockFaceSettings!.ringSettings[sourceRow]
            SettingsViewController.currentClockSetting.clockFaceSettings!.ringSettings.remove(at: sourceRow)
            SettingsViewController.currentClockSetting.clockFaceSettings!.ringSettings.insert(object, at: destRow)
        }
        
//        //swap rowindexes
//        if let sourceCell = tableView.cellForRow(at: sourceIndexPath) as? DecoratorTableViewCell {
//            sourceCell.rowIndex = destRow
//        }
//        if let destCell = tableView.cellForRow(at: destinationIndexPath) as? DecoratorTableViewCell {
//            destCell.rowIndex = sourceRow
//        }
        
        redrawPreview()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if nil != SettingsViewController.currentClockSetting.clockFaceSettings {
                let sourceRow = indexPath.row;
                //let trashedSetting = clockSettings.ringSettings[sourceRow]
                SettingsViewController.currentClockSetting.clockFaceSettings!.ringSettings.remove(at: sourceRow)
                tableView.deleteRows(at: [indexPath], with: .none)
                            
                redrawPreview()
            }
        
        }
    }
    
    func valueForHeader( section: Int) -> String {
        let ringSetting = SettingsViewController.currentClockSetting.clockFaceSettings!.ringSettings[ section ]
        return ringSetting.ringType.rawValue
    }
    
}
