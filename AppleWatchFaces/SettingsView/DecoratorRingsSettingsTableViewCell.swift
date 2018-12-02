//
//  DecoratorRingsSettingsTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/28/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class DecoratorRingsSettingsTableViewCell: WatchSettingsSelectableTableViewCell {
    
    @IBOutlet var decoratorRingsLabel: UILabel!
    @IBOutlet var decoratorRingsButton: UIButton!
    
    // called after a new setting should be selected ( IE a new design is loaded )
    override func chooseSetting( animated: Bool ) {
        //TODO: select the theme based on title?
    }
    
}

