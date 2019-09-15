//
//  Animations.swift
//  Billy
//
//  Created by Kamil Wrobel on 9/4/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit
import AudioToolbox

extension UIViewController {
    
    
    func shake(){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0.09, options: [], animations: {
            self.view.center.x = 0.508 * self.view.frame.width
        }, completion: { (done) in
            if done {
                self.view.center.x = 0.5 * self.view.frame.width
            }
        })
    }
    
    func hapticFeedback(){
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
    
}
