//
//  LogController.swift
//  Billy
//
//  Created by Kamil Wrobel on 7/29/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import Foundation


/*
 
 Version 2.0
 
 
 */

class LogController {
    
    
    static var shared  = LogController()
    private init() {}
    
    var logs = [Log]()
    
    func createLogWith(category: String, amount: Double, date: Date?){
        let log = Log(category: category, amount: amount, date: date)
        logs.append(log)
    }
}
