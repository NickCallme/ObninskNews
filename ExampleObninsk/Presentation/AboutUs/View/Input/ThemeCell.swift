//
//  ThemeCell.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 30.01.2023.
//

import Foundation
import UIKit

class ThemeCell: UITableViewCell {
    
    var label = UILabel()
    var arrowView = UIImageView(image: UIImage(named: "arrow"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        // PROPERTY
        
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        
        arrowView.contentMode = .scaleAspectFill
        
        // CONSTRAINT
        
        contentView.addSubview(arrowView)
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            arrowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowView.heightAnchor.constraint(equalToConstant: 24),
            arrowView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: arrowView.leadingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -17),
            label.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
}
