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
    
    @IBAction func face2(sender: UIButton) {
        debugPrint("face2 tapped")
        
        if let validSession = session {
            let iPhoneAppContext = ["FaceChosen" : "face2" as String]
            
            do {
                try validSession.updateApplicationContext(iPhoneAppContext)
            } catch {
                print("Something went wrong")
            }
        }
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

