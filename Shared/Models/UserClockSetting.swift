//
//  UserClockSetting.swift
//  SwissClock
//
//  Created by Michael Hill on 12/29/15.
//  Copyright © 2015 Mike Hill. All rights reserved.
//

import SpriteKit

class UserClockSetting: NSObject {
    
    static var fileName = "userClockSettingsV01.json" //change this if significant schema changes are made and users will lose their data, but wont crash.  Otherwise, make migration code
    
    static var sharedClockSettings = [ClockSetting]()
    static var sharedColorThemeSettings = [ClockColorTheme]()
    static var sharedDecoratorThemeSettings = [ClockDecoratorTheme]()

    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent(fileName)
    
    static func loadFromFile (_ forceLoadDefaults: Bool = false) {
        
        //load the themes
        if let path = Bundle.main.path(forResource: "Themes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.mappedIfSafe)
                let jsonObj = try! JSON(data: data)
                if jsonObj != JSON.null {
                    //print("jsonDataThemes:\(jsonObj)")
                    
                    //load up the colors
                    sharedColorThemeSettings = []
                    
                    let clockColorThemesSerializedArray = jsonObj["colors"].array
                    for clockThemeSerialized in clockColorThemesSerializedArray! {
                        //print("got title", clockSettingSerialized["title"])
                        let newTheme = ClockColorTheme.init(jsonObj: clockThemeSerialized)
                        sharedColorThemeSettings.append( newTheme )
                    }
                    
                    //load up the decorators
                    sharedDecoratorThemeSettings = []
                    
                    let clockDecoratorThemesSerializedArray = jsonObj["decorators"].array
                    for clockThemeSerialized in clockDecoratorThemesSerializedArray! {
                        let newTheme = ClockDecoratorTheme.init(jsonObj: clockThemeSerialized)
                        print("got decorator title", clockThemeSerialized["title"], "minuteHandMovement ", newTheme.minuteHandMovement)
                        sharedDecoratorThemeSettings.append( newTheme )
                    }
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        //keep track of flag to load defaults or not
        var shouldLoadDefaults = true
        
        //clear it out
        sharedClockSettings = []
        
        //make placeholder serial array
        var clockSettingsSerializedArray = [JSON]()
    
        let path = self.ArchiveURL.path
            do {
                print("JSON file path = \(path)")
                
                //let data = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.mappedIfSafe)
                let jsonObj = try! JSON(data: jsonData)
                if jsonObj != JSON.null {
                    print("LOADED !!! jsonData:\(jsonObj)")
                    clockSettingsSerializedArray = jsonObj["clockSettings"].array!
                    shouldLoadDefaults = false
                } else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
            } catch let error as NSError {
                print("error", error.localizedDescription)
                
                //TODO: check for exact no file error
                
                //if no file, initialize with default data
                
            }
        
        //if nothing found / loaded, load defaults
        
        if (shouldLoadDefaults || forceLoadDefaults) {
            if let path = Bundle.main.path(forResource: "Settings", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.mappedIfSafe)
                    let jsonObj = try! JSON(data: data)
                    if jsonObj != JSON.null {
                        //print("jsonDataFromDefaults:\(jsonObj)")
                        clockSettingsSerializedArray = jsonObj["clockSettings"].array!
                    } else {
                        print("could not get json from file, make sure that file contains valid json.")
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else {
                print("Invalid filename/path.")
            }
        }
        
        //load serialized data into shared clock settings
        for clockSettingSerialized in clockSettingsSerializedArray {
            //print("got title", clockSettingSerialized["title"])
            let newClockSetting = ClockSetting.init(jsonObj: clockSettingSerialized)
            //debugPrint("n:" + newClockSetting.title + " " + newClockSetting.uniqueID)
            sharedClockSettings.append( newClockSetting )
        }
        
    }
    
    static func resetToDefaults() {
        loadFromFile(true)
        saveToFile()
    }

    static func saveToFile () {
        //JSON save to file
        var serializedArray = [NSDictionary]()
        for clockSetting in sharedClockSettings {
            serializedArray.append(clockSetting.serializedSettings() )
            
            //debugPrint("saving setting: ", clockSetting.title)
            
        }
        
        let dictionary = ["clockSettings": serializedArray]
        
        if JSONSerialization.isValidJSONObject(dictionary) {
            do {
                
                let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted )
                // here "jsonData" is the dictionary encoded in JSON data
                let theJSONText = NSString(data: jsonData, encoding: String.Encoding.ascii.rawValue)
                //debugPrint("JSON string = \(theJSONText!)")
                    
                //save to a file
                let path = self.ArchiveURL.path
                debugPrint("SAVING: JSON file path = \(path)")
                
                //writing
                do {
                    try theJSONText!.write(toFile: path, atomically: false, encoding: String.Encoding.utf8.rawValue)
                }
                catch let error as NSError {
                    print("save write file error: ", error.localizedDescription)
                }

                
            } catch let error as NSError {
                print("save JSON serialization error: ", error.localizedDescription)
            }
        } else {
            print("ERROR: settings cant be coverted to JSON")
        }
        
    }
    
    static func firstColorTheme() -> ClockColorTheme {
        return sharedColorThemeSettings[0]
    }
    
    static func randomColorTheme() -> ClockColorTheme {
        let randomIndex = Int(arc4random_uniform(UInt32(sharedColorThemeSettings.count)))
        return sharedColorThemeSettings[randomIndex]
    }
    
    static func colorThemesList() -> [String] {
        var themesArray = [String]()
        
        for themeSetting in sharedColorThemeSettings {
            themesArray.append(themeSetting.title)
        }
        
        return themesArray
    }
    
    static func firstDecoratorTheme() -> ClockDecoratorTheme {
        return sharedDecoratorThemeSettings[0]
    }
    
    static func randomDecoratorTheme() -> ClockDecoratorTheme {
        let randomIndex = Int(arc4random_uniform(UInt32(sharedDecoratorThemeSettings.count)))
        return sharedDecoratorThemeSettings[randomIndex]
    }
    
    static func decoratorThemesList() -> [String] {
        var themesArray = [String]()
        
        for themeSetting in sharedDecoratorThemeSettings {
            themesArray.append(themeSetting.title)
        }
        
        return themesArray
    }
    

}
