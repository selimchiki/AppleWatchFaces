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
    @IBOutlet var materialSegment: UISegmentedControl!
    @IBOutlet var totalNumbersSegment: UISegmentedControl!
    @IBOutlet var valueSlider: UISlider!
    
    override func transitionToEditMode() {
        self.materialSegment.isHidden = true
        self.totalNumbersSegment.isHidden = true
        self.valueSlider.isHidden = true
    }
    
    override func transitionToNormalMode() {
        self.materialSegment.isHidden = false
        self.totalNumbersSegment.isHidden = false
        self.valueSlider.isHidden = false
    }
    
    func shapeChosen( shapeType: FaceIndicatorTypes ) {
        //debugPrint("fontChosen" + NumberTextNode.descriptionForType(textType))
        
        let clockRingSetting = myClockRingSetting()
        clockRingSetting.indicatorType = shapeType
        self.titleLabel.text = titleText(clockRingSetting: clockRingSetting)
        
        NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil,
                                        userInfo:["settingType":"indicatorType" ])
    }
    
    @IBAction func editShape(sender: UIButton ) {
        self.selectThisCell()
        
        NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsEditDetailNotificationName, object: nil,
                                        userInfo:["settingType":"indicatorType", "decoratorShapeTableViewCell":self ])
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
    
    @IBAction func sliderValueDidChange(sender: UISlider ) {
        self.selectThisCell()
        
        debugPrint("slider value:" + String( sender.value ) )
        let clockRingSetting = myClockRingSetting()

        let roundedValue = Float(round(100*sender.value)/100)
        if roundedValue != clockRingSetting.indicatorSize {
            
            clockRingSetting.indicatorSize = sender.value
            NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil,
                                        userInfo:["settingType":"indicatorSize" ])
        }
    }
    
    func titleText( clockRingSetting: ClockRingSetting ) -> String {
        return ClockRingSetting.descriptionForRingType(clockRingSetting.ringType) + " : " + FaceIndicatorNode.descriptionForType(clockRingSetting.indicatorType)
    }
    
    override func setupUIForClockRingSetting( clockRingSetting: ClockRingSetting ) {
        super.setupUIForClockRingSetting(clockRingSetting: clockRingSetting)
        
        self.titleLabel.text = titleText(clockRingSetting: clockRingSetting)
        self.materialSegment.selectedSegmentIndex = clockRingSetting.ringMaterialDesiredThemeColorIndex
        
        let totalString = String(clockRingSetting.ringPatternTotal)
        if let segmentIndex = ClockRingSetting.ringTotalOptions().index(of: totalString) {
            self.totalNumbersSegment.selectedSegmentIndex = segmentIndex
        }
        
        valueSlider.minimumValue = AppUISettings.ringSettigsSliderShapeMin
        valueSlider.maximumValue = AppUISettings.ringSettigsSliderShapeMax
            
        valueSlider.value = clockRingSetting.indicatorSize
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
