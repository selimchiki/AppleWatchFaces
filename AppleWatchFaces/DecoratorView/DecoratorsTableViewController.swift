//
//  DecoratorsTableViewController.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 12/2/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit

class DecoratorsTableViewController: UITableViewController {

    func redrawPreview() {
        //tell clock previe to redraw!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.isEditing = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return SettingsViewController.currentClockSetting.clockFaceSettings!.ringSettings.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "decoratorEditorID", for: indexPath) as! DecoratorTableViewCell

        if let clockSettings = SettingsViewController.currentClockSetting.clockFaceSettings {
            let ringSetting = clockSettings.ringSettings[indexPath.section]
            cell.titleLabel.text = ringSetting.ringType.rawValue
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let sourceRow = sourceIndexPath.section;
        let destRow = destinationIndexPath.section;
        
        if let clockSettings = SettingsViewController.currentClockSetting.clockFaceSettings {
            let object = clockSettings.ringSettings[sourceRow]
            clockSettings.ringSettings.remove(at: sourceRow)
            clockSettings.ringSettings.insert(object, at: destRow)
        }
        
        redrawPreview()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let clockSettings = SettingsViewController.currentClockSetting.clockFaceSettings {
                let sourceRow = indexPath.section;
                //let trashedSetting = clockSettings.ringSettings[sourceRow]
                clockSettings.ringSettings.remove(at: sourceRow)
                tableView.deleteSections([sourceRow], with: .fade)
            }
        
        }
    }
    

}
