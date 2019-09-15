//
//  CustomButton.swift
//  Billy
//
//  Created by Kamil Wrobel on 7/20/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit



class CustomButton: UIButton {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = .clear
        self.setTitleShadowColor(.darkGray, for: .normal)
        self.setTitleColor(.white, for: .normal)
    }
    
    

}


extension UIButton {
    func hapticFeedback(){
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
}
