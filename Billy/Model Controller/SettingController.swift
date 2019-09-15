//
//  SettingController.swift
//  Billy
//
//  Created by Kamil Wrobel on 3/13/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import Foundation


class SettingController {
    
    static var shared = SettingController()
    private init(){}
    
    var initialLaunch = true
    
    
    private let eightThirtyInSecondsForUTCTime : Double = 48640
    var setting = Setting(dayDelay: 5, notificationTime: Date(timeIntervalSince1970: 48640), notifyTwoDaysBefore: true, notifyOnDay: true)
    
    var notificationState : [Notificationstate] = []
    
    
    func checkNotificationStates(){
        var notificationStates: [Notificationstate] = []
        notificationStates.append(.custom)
        if SettingController.shared.setting.notifyOnDay == true {
            notificationStates.append(.onADueDate)
        }
        if SettingController.shared.setting.notifyTwoDaysBefore == true {
            notificationStates.append(.twoDaysBefore)
        }
        notificationState = notificationStates
    }
    
    
    //MARK: - Save settings method
    func saveSettings(){
        let jasonEncoder = PropertyListEncoder()
        do {
            let data = try jasonEncoder.encode(self.setting)
            try data.write(to: fileURL())
        } catch let error {
            print("Error encoding data: \(error)")
        }
    }
    
    
    //MARK: - Load  settings method
    func loadSettings(){
        let jasonDecoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let loadedSetting = try jasonDecoder.decode(Setting.self, from: data)
            setting = loadedSetting
        } catch let error {
            print("Error decoding setting data: \(error)")
        }
    }
    
    
    //MARK: - Path to where the settings are saved
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "setting JSON"
        let fullURL = documentDirectory.appendingPathComponent(fileName)
        return fullURL
        
    }
}
