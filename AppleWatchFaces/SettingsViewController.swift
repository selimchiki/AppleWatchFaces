//
//  ViewController.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 10/17/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit
import WatchConnectivity

class SettingsViewController: UIViewController, WCSessionDelegate {
    
    var session: WCSession?
    var watchPreviewViewController:WatchPreviewViewController?
    static var currentClockSetting: ClockSetting = ClockSetting.defaults()
    
    static let settingsChangedNotificationName = Notification.Name("settingsChanged")
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        debugPrint("session activationDidCompleteWith")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        debugPrint("session sessionDidBecomeInactive")
    }

    func sessionDidDeactivate(_ session: WCSession) {
        debugPrint("session sessionDidDeactivate")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is WatchPreviewViewController
        {
            let vc = segue.destination as? WatchPreviewViewController
            watchPreviewViewController = vc
        }
    }
    
    @IBAction func sendSettingAction(sender: UIButton) {
        debugPrint("sendSetting tapped")
        if let validSession = session {
            if let curClockSettingString = SettingsViewController.currentClockSetting.toJSONString(){
                validSession.sendMessage(["curClockSettingString":curClockSettingString as String], replyHandler: { reply in
                                        debugPrint("reply")
                                    }, errorHandler: { error in
                                        print("error: \(error)")
                                    })
            }
        }
        
//        if let validSession = session {
//            if let curClockSetting = SettingsViewController.currentClockSetting.toJSON() {
//                let settingJSONContext = ["newSetting" : curClockSetting as JSON]
//
//                validSession.sendMessage(settingJSONContext, replyHandler: { reply in
//                    debugPrint("reply")
//                }, errorHandler: { error in
//                    print("error: \(error)")
//                })
//
//            }
//        }
    
    }
    
    @IBAction func face1(sender: UIButton) {
        debugPrint("face1 tapped")
        
        if let validSession = session {
            let iPhoneAppContext = ["FaceChosen" : "face1" as String]
            
            do {
                try validSession.updateApplicationContext(iPhoneAppContext)
            } catch {
                print("Something went wrong")
            }
        }
    
        //WatchSessionManager.sharedManager.sendMessage(message: ["FaceChosen" : "face1" as AnyObject])
    }
    
    @objc func onNotification(notification:Notification)
    {
        //tell preview to reload
        if watchPreviewViewController != nil {
            watchPreviewViewController?.redraw()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(notification:)), name: SettingsViewController.settingsChangedNotificationName, object: nil)
        
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
}

