//
//  CustomViewWithRoundedCorners.swift
//  Billy
//
//  Created by Kamil Wrobel on 3/10/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit

class CustomViewWithRoundedCorners: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 9
    }
}
