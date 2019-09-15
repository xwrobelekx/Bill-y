//
//  Setting.swift
//  Billy
//
//  Created by Kamil Wrobel on 3/12/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import Foundation


class Setting: Codable, Equatable {
    var dayDelay: Int
    var notificationTime: Date?
    var notifyTwoDaysBefore: Bool
    var notifyOnDay: Bool
    
    init(dayDelay: Int, notificationTime: Date?, notifyTwoDaysBefore: Bool = true, notifyOnDay: Bool = true){
        self.dayDelay = dayDelay
        self.notificationTime = notificationTime
        self.notifyTwoDaysBefore = notifyTwoDaysBefore
        self.notifyOnDay = notifyOnDay
    }
    
    static func == (lhs: Setting, rhs: Setting) -> Bool {
       return lhs.dayDelay == rhs.dayDelay
    }
    
}
