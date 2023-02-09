//
//  stackViewSeparator.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 30.01.2023.
//

import UIKit

extension UIStackView {
    
    func addSeparators(color: UIColor) {
        
        var step = 1
        
        for position in 0...subviews.count - 1 {
            
            let separator = UIView()
            separator.backgroundColor = color
            insertArrangedSubview(separator, at: position + step)
            step += 1
            
            switch self.axis {
            case .horizontal:
                separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
                separator.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
            case .vertical:
                separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
                separator.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
            @unknown default:
                fatalError("Unknown UIStackView axis value.")
            }
        }
    }
    
}
