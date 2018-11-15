//
//  FaceChooserViewController.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 11/14/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit
import WatchConnectivity

class FaceChooserViewController: UIViewController, WCSessionDelegate {
    
    var session: WCSession?
    @IBOutlet var errorMessageLabel: UILabel!
    
    @IBAction func sendAllSettingsAction(sender: UIButton) {
        //debugPrint("sendAllSettingsAction tapped")
        if let validSession = session {
            
            validSession.transferFile(UserClockSetting.ArchiveURL, metadata: ["type":"settingsFile"])
            
        } else {
            self.showError(errorMessage: "No valid watch session")
        }
    }
    
    @IBAction func resetAllSettingAction(sender: UIButton) {
        UserClockSetting.resetToDefaults()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        //
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //
    }
    
    func showError( errorMessage: String) {
        DispatchQueue.main.async {
            self.errorMessageLabel.textColor = UIColor.red
            self.errorMessageLabel.text = errorMessage
            
            self.errorMessageLabel.alpha = 1.0
            UIView.animate(withDuration: 1.0, delay: 3.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.errorMessageLabel.alpha = 0.0
            }) { (completed) in
                //
            }
        }
    }
    
    func showMessage( message: String) {
        DispatchQueue.main.async {
            self.errorMessageLabel.textColor = UIColor.lightGray
            self.errorMessageLabel.text = message
            
            self.errorMessageLabel.alpha = 1.0
            UIView.animate(withDuration: 1.0, delay: 3.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.errorMessageLabel.alpha = 0.0
            }) { (completed) in
                //
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserClockSetting.loadFromFile()
    }

    

}
