//
//  IntroInterfaceController.swift
//  Face Extension
//
//  Created by Michael Hill on 11/8/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import WatchKit

class IntroInterfaceController: WKInterfaceController {
    override func awake(withContext context: Any?) {
        
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        presentController(withName: "InterfaceController", context: nil)
        
    }
    
    override func willActivate() {
        
        // This method is called when watch view controller is about to be visible to user
        
        super.willActivate()
        
    }
    
    override func didDeactivate() {
        
        // This method is called when watch view controller is no longer visible
        
        super.didDeactivate()
        
    }
    
    @IBAction func goToWatchFace() {
        
        presentController(withName: "InterfaceController", context: nil)
        
    }
    
}
