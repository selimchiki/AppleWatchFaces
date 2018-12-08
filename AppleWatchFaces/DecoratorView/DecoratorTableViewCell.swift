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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
