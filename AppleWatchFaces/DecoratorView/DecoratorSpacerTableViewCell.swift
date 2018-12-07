//
//  DecoratorTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 12/2/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit

class DecoratorSpacerTableViewCell: DecoratorTableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueSlider: UISlider!
    
    @IBAction func sliderValueDidChange(sender: UISlider ) {
        //debugPrint("slider value:" + String( sender.value ) )
        let clockRingSetting = myClockRingSetting()
        
        let roundedValue = Float(round(100*sender.value)/100)
        if roundedValue != clockRingSetting.ringWidth {
            clockRingSetting.ringWidth = sender.value
            NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil,
                                        userInfo:["settingType":"ringWidth" ])
        }
    }
    
    override func setupUIForClockRingSetting( clockRingSetting: ClockRingSetting ) {
        super.setupUIForClockRingSetting(clockRingSetting: clockRingSetting)
    
        self.titleLabel.text = ClockRingSetting.descriptionForRingType(clockRingSetting.ringType)
        
        valueSlider.minimumValue = AppUISettings.ringSettigsSliderSpacerMin
        valueSlider.maximumValue = AppUISettings.ringSettigsSliderSpacerMax
            
        valueSlider.value = clockRingSetting.ringWidth
        
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
