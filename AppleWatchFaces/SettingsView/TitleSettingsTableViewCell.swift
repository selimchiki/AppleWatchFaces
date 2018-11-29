//
//  TitleSettingsTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/28/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit

class TitleSettingsTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet var titleTextView:UITextField!
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //hello!
        let newTitle = textField.text ?? ""
        debugPrint("did end editing title:" + newTitle)
        SettingsViewController.currentClockSetting.title = newTitle
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
