//
//  RoundedTextView.swift
//  Billy
//
//  Created by Kamil Wrobel on 9/4/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit


class RoundedTextField: UITextView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = .clear
        self.layer.cornerRadius = 9
        self.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    
    //MARK: - Settings
    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: contentSize.height)
    }
    
}
