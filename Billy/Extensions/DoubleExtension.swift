//
//  DoubleExtension.swift
//  Billy
//
//  Created by Kamil Wrobel on 7/10/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import Foundation


extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
