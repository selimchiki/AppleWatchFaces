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
            self.showMessage(message: "Sending ...")
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: UserClockSetting.ArchiveURL.absoluteString) {
                validSession.transferFile(UserClockSetting.ArchiveURL, metadata: ["type":"settingsFile"])
            } else {
                self.showError(errorMessage: "No changes to send")
            }
        } else {
            self.showError(errorMessage: "No valid watch session")
        }
    }
    
    @IBAction func resetAllSettingAction(sender: UIButton) {
        UserClockSetting.resetToDefaults()
    }
    
    func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
        if let error = error {
            self.showError(errorMessage: error.localizedDescription)
        } else {
            self.showMessage(message: "All settings sent")
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //debugPrint("session activationDidCompleteWith")
        showMessage( message: "Watch session active.")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        //debugPrint("session sessionDidBecomeInactive")
        showError(errorMessage: "Watch session became inactive.")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //debugPrint("session sessionDidDeactivate")
        showError(errorMessage: "Watch session deactivated.")
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
    
    override func viewDidAppear(_ animated: Bool) {
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserClockSetting.loadFromFile()
    }

    

}
