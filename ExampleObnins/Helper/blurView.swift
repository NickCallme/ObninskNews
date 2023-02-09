//
//  blurView.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 21.01.2023.
//

import UIKit

protocol Blurable {
    func addBlur(_ alpha: CGFloat)
}

extension Blurable where Self: UIView {
    func addBlur(_ alpha: CGFloat = 0.5) {
        // create effect
        let effect = UIBlurEffect(style: .extraLight)
        let effectView = UIVisualEffectView(effect: effect)
        
        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        
        self.addSubview(effectView)
    }
}

extension UIView: Blurable {}
