//
//  InterfaceController.swift
//  Face Extension
//
//  Created by Michael Hill on 10/17/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation

class InterfaceController: KKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var skInterface: WKInterfaceSKScene!
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    let session = WCSession.default
    
    var currentClockSetting: ClockSetting = ClockSetting.defaults()
    
    //sending the whole settings file
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        // Create a FileManager instance
        let fileManager = FileManager.default
        
        do {
            try fileManager.copyItem(at: file.fileURL, to: UserClockSetting.ArchiveURL)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        
        //reload userClockSettings
        UserClockSetting.loadFromFile()
    }
    
    //got one new setting
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        do {
            let jsonObj = try JSON(data: messageData)
            if jsonObj != JSON.null {
                let newClockSetting = ClockSetting.init(jsonObj: jsonObj)
                currentClockSetting = newClockSetting
                if let skWatchScene = self.skInterface.scene as? SKWatchScene {
                    skWatchScene.redraw(clockSetting: currentClockSetting)
                }
                replyHandler("success".data(using: .utf8) ?? Data.init())
            }
        } catch {
                replyHandler("error".data(using: .utf8) ?? Data.init())
        }
    }
    
//    func processApplicationContext() {
//        if let iPhoneContext = session.receivedApplicationContext as? [String : String] {
//            debugPrint("FaceChosen" + iPhoneContext["FaceChosen"]!)
//
//            if let chosenFace = iPhoneContext["FaceChosen"] {
//
//                UserDefaults.standard.set(chosenFace, forKey: "FaceChosen")
//
//                if let skWatchScene = self.skInterface.scene as? SKWatchScene {
//                    skWatchScene.redraw(clockSetting: currentClockSetting)
//                }
//            }
//
//
//        }
//    }
    
//    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
//        DispatchQueue.main.async() {
//            self.processApplicationContext()
//        }
//    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        //load the last settings
        UserClockSetting.loadFromFile()
        
        setTitle(" ")
        
        // Configure interface objects here.
        session.delegate = self
        session.activate()
        
        
        // Load the SKScene
        if let scene = SKWatchScene(fileNamed: "SKWatchScene") {
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            self.skInterface.presentScene(scene)
            
            // Use a value that will maintain a consistent frame rate
            self.skInterface.preferredFramesPerSecond = 30
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        skInterface.isPaused = false
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
