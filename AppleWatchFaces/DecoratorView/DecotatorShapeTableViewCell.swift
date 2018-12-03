//
//  DecoratorTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 12/2/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit

class DecoratorShapeTableViewCell: DecoratorTableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var shapeTypeTitleLabel: UILabel!
    @IBOutlet var valueSlider: UISlider!
    
    func myClockRingSetting()->ClockRingSetting {
        return (SettingsViewController.currentClockSetting.clockFaceSettings?.ringSettings[rowIndex])!
    }
    
    @IBAction func sliderValueDidChange(sender: UISlider ) {
        debugPrint("slider value:" + String( sender.value ) )
        let clockRingSetting = myClockRingSetting()
        clockRingSetting.textSize = sender.value
        NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil,
                                        userInfo:["settingType":"sliderValue" ])
    }
    
    override func setupUIForClockRingSetting() {
        super.setupUIForClockRingSetting()
        
        let clockRingSetting = myClockRingSetting()
        
        self.titleLabel.text = ClockRingSetting.descriptionForRingType(clockRingSetting.ringType)
        
        if clockRingSetting.ringType == .RingTypeTextNode || clockRingSetting.ringType == .RingTypeTextRotatingNode {
            valueSlider.minimumValue = AppUISettings.ringSettigsSliderTextMin
            valueSlider.maximumValue = AppUISettings.ringSettigsSliderTextMax
            
            valueSlider.value = clockRingSetting.textSize
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
