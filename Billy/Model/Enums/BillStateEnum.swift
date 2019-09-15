//
//  BillStateEnum.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/31/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation

enum BillState {
    case isPaid
    case isPastDue
    case isDueInFiveDays
    case isDueNextWeek
    case isDueInTwoWeeks
    case isDueThisMonth
    case otherBills
}
