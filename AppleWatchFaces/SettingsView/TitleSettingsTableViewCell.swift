//
//  TitleSettingsTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/28/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit

class TitleSettingsTableViewCell: WatchSettingsSelectableTableViewCell, UITextFieldDelegate {

    @IBOutlet var titleTextView:UITextField!
    
    // called after a new setting should be selected ( IE a new design is loaded )
    override func chooseSetting( animated: Bool ) {
        //TODO: select the theme based on title?
        titleTextView.text = SettingsViewController.currentClockSetting.title
    }
    
    @IBAction func toggleSwitchButtonAction( sender: UIButton ) {
        titleTextView.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //hello!
        let newTitle = textField.text ?? ""
        debugPrint("did end editing title:" + newTitle)
        SettingsViewController.currentClockSetting.title = newTitle
        
        NotificationCenter.default.post(name: SettingsViewController.settingsChangedNotificationName, object: nil, userInfo:nil)
        NotificationCenter.default.post(name: WatchSettingsTableViewController.settingsTableSectionReloadNotificationName, object: nil,
                                        userInfo:["cellId": self.cellId , "settingType":"clockFaceSettings.title"])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextView.resignFirstResponder()

        return true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleTextView.delegate = self
        
        titleTextView.text = SettingsViewController.currentClockSetting.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
