//
//  DecoratorTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 12/2/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit

class DecoratorTextTableViewCell: DecoratorTableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var fontTitleLabel: UILabel!
    @IBOutlet var valueSlider: UISlider!
    @IBOutlet var rotatingSwitch: UISwitch!
    @IBOutlet var materialSegment: UISegmentedControl!
    @IBOutlet var totalNumbersSegment: UISegmentedControl!
    
    override func transitionToEditMode() {
        self.fontTitleLabel.isHidden = true
        self.materialSegment.isHidden = true
        self.totalNumbersSegment.isHidden = true
        self.valueSlider.isHidden = true
        self.rotatingSwitch.isHidden = true
    }
    
    override func transitionToNormalMode() {
        self.fontTitleLabel.isHidden = false
        self.materialSegment.isHidden = false
        self.totalNumbersSegment.isHidden = false
        self.valueSlider.isHidden = false
        self.rotatingSwitch.isHidden = false
    }
    
    func fontChosen( textType: NumberTextTypes ) {
        //debugPrint("fontChosen" + NumberTextNode.descriptionForType(textType))
        
        let clockRingSetting = myClockRingSetting()
        clockRingSetting.textType = textType
        self.fontTitleLabel.text =  NumberTextNode.descriptionForType(clockRingSetting.textType)
        NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil,
                                        userInfo:["settingType":"textType" ])
    }
    
    @IBAction func editType(sender: UIButton ) {
        self.selectThisCell()
        
        NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsEditDetailNotificationName, object: nil,
                                        userInfo:["settingType":"textType", "decoratorTextTableViewCell":self ])
    }
      
    @IBAction func totalSegmentDidChange(sender: UISegmentedControl ) {
        self.selectThisCell()
        
        let clockRingSetting = myClockRingSetting()
        clockRingSetting.ringPatternTotal = Int(ClockRingSetting.ringTotalOptions()[sender.selectedSegmentIndex])!
        clockRingSetting.ringPattern = [1] // all on for now
        NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil,
                                        userInfo:["settingType":"ringPatternTotal" ])
    }
    
    @IBAction func segmentDidChange(sender: UISegmentedControl ) {
        self.selectThisCell()
        
        //debugPrint("segment value:" + String( sender.selectedSegmentIndex ) )
        let clockRingSetting = myClockRingSetting()
        clockRingSetting.ringMaterialDesiredThemeColorIndex = sender.selectedSegmentIndex
        NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil,
                                        userInfo:["settingType":"ringMaterialDesiredThemeColorIndex" ])
    }
    
    @IBAction func switchDidChange(sender: UISwitch ) {
        self.selectThisCell()
        
        //debugPrint("switch value:" + String( sender.isOn ) )
        let clockRingSetting = myClockRingSetting()
        if sender.isOn {
            clockRingSetting.ringType = .RingTypeTextRotatingNode
        } else {
            clockRingSetting.ringType = .RingTypeTextNode
            
        }
        self.titleLabel.text = ClockRingSetting.descriptionForRingType(clockRingSetting.ringType)
        NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil,
                                        userInfo:["settingType":"textType" ])
    }
    
    @IBAction func sliderValueDidChange(sender: UISlider ) {
        self.selectThisCell()
        
        //debugPrint("slider value:" + String( sender.value ) )
        let clockRingSetting = myClockRingSetting()
        
        let roundedValue = Float(round(100*sender.value)/100)
        if roundedValue != clockRingSetting.textSize {
            //debugPrint("new value:" + String( roundedValue ) )
            clockRingSetting.textSize = roundedValue
            NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil,
                                            userInfo:["settingType":"textSize" ])
        }
    
    }
    
    override func setupUIForClockRingSetting( clockRingSetting: ClockRingSetting ) {
        super.setupUIForClockRingSetting(clockRingSetting: clockRingSetting)
                
        self.titleLabel.text = ClockRingSetting.descriptionForRingType(clockRingSetting.ringType)
        self.fontTitleLabel.text =  NumberTextNode.descriptionForType(clockRingSetting.textType)
        self.materialSegment.selectedSegmentIndex = clockRingSetting.ringMaterialDesiredThemeColorIndex
        
        let totalString = String(clockRingSetting.ringPatternTotal)
        if let segmentIndex = ClockRingSetting.ringTotalOptions().index(of: totalString) {
            self.totalNumbersSegment.selectedSegmentIndex = segmentIndex
        }
        
        if clockRingSetting.ringType == .RingTypeTextRotatingNode {
            self.rotatingSwitch.isOn = true
        } else {
            self.rotatingSwitch.isOn = false
        }
        
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
    
}
