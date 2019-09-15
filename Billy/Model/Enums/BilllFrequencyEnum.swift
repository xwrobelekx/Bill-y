//
//  BilllFrequencyEnum.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/5/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation


enum BillFrequency: String, CaseIterable {
    case none = "One Time Payment"
    case weekly = "Weekly Payment"
    case biweekly = "Biweekly Payment"
    case monthly = "Monthly Payment"
    case quarterly = "Quarterly Payment"
    case semiAnual = "Semi Anual Payment"
    case anual = "Anual Payment"
}
