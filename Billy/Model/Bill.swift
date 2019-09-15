//
//  Bill.swift
//  Billy
//
//  Created by Kamil Wrobel on 3/12/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import Foundation


class NewBill : Codable, Equatable, Hashable{
    var title: String
    var dueDate: Date
    var paymentAmount: Double
    var isPaid: Bool = false
    var notificationIdentyfier: [String]
    var notes: String?
    var uid : String
    var setting: Setting
    
    init(title: String, dueDate: Date, paymentAmount: Double, isPaid: Bool = false, notificationIdentyfier: [String], notes: String?, uid: String = UUID().uuidString, setting: Setting){
        self.title = title
        self.dueDate = dueDate
        self.paymentAmount = paymentAmount
        self.isPaid = isPaid
        self.notificationIdentyfier = notificationIdentyfier
        self.notes = notes
        self.uid = uid
        self.setting = setting
    }
    
    
    static func == (lhs: NewBill, rhs: NewBill) -> Bool {
//        if lhs.title != rhs.title {return false}
//        if lhs.dueDate != rhs.dueDate {return false}
//        if lhs.paymentAmount != rhs.paymentAmount {return false}
//        if lhs.isPaid != rhs.isPaid {return false}
//        if lhs.notificationIdentyfier != rhs.notificationIdentyfier {return false}
        if lhs.uid != rhs.uid {return false}
        return true
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
}




