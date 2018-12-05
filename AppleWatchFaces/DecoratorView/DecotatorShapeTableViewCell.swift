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
    @IBOutlet var materialSegment: UISegmentedControl!
    @IBOutlet var valueSlider: UISlider!
    
    func myClockRingSetting()->ClockRingSetting {
        return (SettingsViewController.currentClockSetting.clockFaceSettings?.ringSettings[rowIndex])!
    }
    
    @IBAction func segmentDidChange(sender: UISegmentedControl ) {
        //debugPrint("segment value:" + String( sender.selectedSegmentIndex ) )
        let clockRingSetting = myClockRingSetting()
        clockRingSetting.ringMaterialDesiredThemeColorIndex = sender.selectedSegmentIndex
        NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil,
                                        userInfo:["settingType":"ringMaterialDesiredThemeColorIndex" ])
    }
    
    @IBAction func sliderValueDidChange(sender: UISlider ) {
        //debugPrint("slider value:" + String( sender.value ) )
        let clockRingSetting = myClockRingSetting()

        let roundedValue = Float(round(100*sender.value)/100)
        if roundedValue != clockRingSetting.indicatorSize {
            
            clockRingSetting.indicatorSize = sender.value
            NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil,
                                        userInfo:["settingType":"indicatorSize" ])
        }
    }
    
    override func setupUIForClockRingSetting() {
        super.setupUIForClockRingSetting()
        
        let clockRingSetting = myClockRingSetting()
        
        self.titleLabel.text = ClockRingSetting.descriptionForRingType(clockRingSetting.ringType)
        self.shapeTypeTitleLabel.text = FaceIndicatorNode.descriptionForType(clockRingSetting.indicatorType)
        self.materialSegment.selectedSegmentIndex = clockRingSetting.ringMaterialDesiredThemeColorIndex
        
        valueSlider.minimumValue = AppUISettings.ringSettigsSliderShapeMin
        valueSlider.maximumValue = AppUISettings.ringSettigsSliderShapeMax
            
        valueSlider.value = clockRingSetting.indicatorSize
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
