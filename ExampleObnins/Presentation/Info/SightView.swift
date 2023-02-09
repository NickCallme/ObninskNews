//
//  SightView.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 26.01.2023.
//

import Foundation
import UIKit

class SightView: UIView {
    
    private let imageView = UIImageView()
    private let textLabel = UILabel()
    
    private func setupView() {
        
        // PROPERTY
        self.backgroundColor = .white
        
        imageView.contentMode = .scaleAspectFill
        
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 17)

        // CONSTRAINT
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 266/343).isActive = true
        
        self.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setupSight(sight: Sight) {
        
        self.imageView.image = UIImage(named: sight.sightImage)
        self.textLabel.text = sight.sightText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, sight: Sight) {
        super.init(frame: frame)
        
        setupSight(sight: sight)
        setupView()
    }
    
}
