//
//  DateFormater.swift
//  Billy
//
//  Created by Kamil Wrobel on 11/29/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation


extension Date {
    
    func asString() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
    func asStringLonger() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
    func dayAndMonthAsString() -> String {
        let customFormat = "ddMM"
        let locale = Locale(identifier: "en_US")
        let format = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func monthAsString() -> String {
        let customFormat = "MM"
        let locale = Locale(identifier: "en_US")
        let format = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func yearAsInt() -> Int {
        let customFormat = "YYYY"
        let locale = Locale(identifier: "en_US")
        let format = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return Int(formatter.string(from: self))!
    }
    
    func monthAsInt() -> Int {
        let customFormat = "MM"
        let locale = Locale(identifier: "en_US")
        let format = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return Int(formatter.string(from: self))!
    }
    
    func timeAsString() -> String{
        let customFormat = "HH:mm"
        let locale = Locale(identifier: "en_US")
        let format = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func hour() -> (hour: Int, min: Int){
        let pickedTime = self.timeAsString()
        let time = pickedTime.split(separator: ":")
        let hour = Int(time[0])!
        let min = Int(time[1])!
        return (hour, min)
        
    }
    
    func timeAsStringWithAMSymbol() -> String {
        let customFormat = "h:mm a"
        let locale = Locale(identifier: "en_US_POSIX")
        let format = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.dateFormat = format
        return formatter.string(from: self)
        //Prints 12:00 AM or 1:05 PM
    }
    
}


