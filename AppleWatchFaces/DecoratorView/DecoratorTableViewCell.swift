//
//  DecoratorTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 12/2/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit

class DecoratorTableViewCell: UITableViewCell {
    
    //var rowIndex:Int=0
    var parentTableview : UITableView?
    
    func transitionToEditMode() {
        // to be overriden by children
    }
    func transitionToNormalMode() {
        // to be overriden by children
    }
    
    override func willTransition(to state: UITableViewCell.StateMask) {
        
    }
    override func didTransition(to state: UITableViewCell.StateMask) {
        if state.contains(UITableViewCell.StateMask.showingEditControl) {
            debugPrint("moving to edit mode!")
            transitionToEditMode()
            self.parentTableview?.reloadSections(IndexSet.init(integer: 0), with: UITableView.RowAnimation.automatic)
        } else {
            transitionToNormalMode()
            self.parentTableview?.reloadSections(IndexSet.init(integer: 0), with: UITableView.RowAnimation.automatic)
        }
    }
    
    func myClockRingSetting()->ClockRingSetting {
        if let tableView = parentTableview, let indexPath = tableView.indexPath(for: self) {
            return (SettingsViewController.currentClockSetting.clockFaceSettings?.ringSettings[indexPath.row])!
        } else {
            debugPrint("** CANT GET index for tableCell, might be out of view?")
            return ClockRingSetting.defaults()
        }
    }

    func setupUIForClockRingSetting( clockRingSetting: ClockRingSetting ) {
        //to be implemented by subClasses
    }
    
//    override func didMoveToSuperview() {
//        self.setupUIForClockRingSetting()
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func selectThisCell() {
        if let tableView = parentTableview, let indexPath = tableView.indexPath(for: self) {
            
            if let selectedPath = tableView.indexPathForSelectedRow {
                if selectedPath == indexPath { return } //already selected -- exit early
            }
            
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.none)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //dont change color
        self.contentView.backgroundColor = self.backgroundColor
        
//        if selected {
//            self.layer.cornerRadius = 2.0
//            self.layer.borderWidth = 2.0
//            self.layer.borderColor = UIColor.init(hexString: AppUISettings.settingHighlightColor).cgColor
//        } else {
//            self.layer.cornerRadius = 0.0
//            self.layer.borderWidth = 0.0
//        }
    }

}
