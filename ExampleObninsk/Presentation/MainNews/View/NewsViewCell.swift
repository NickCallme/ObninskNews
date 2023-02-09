//
//  TableViewCell.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 19.01.2023.
//

import UIKit
import Kingfisher

class NewsViewCell: UITableViewCell {
    
    private var image = UIImageView()
    private var headerNewsLabel = UILabel()
    private var textNewsLabel = UILabel()
    private var dateLabel = UILabel()
    
    weak var newsViewCellModel: NewsViewCellModelType? {
        willSet(newsViewCellModel) {
            guard let newsViewCellModel else { return }
            image.kf.setImage(with: URL(string: newsViewCellModel.image))
            headerNewsLabel.text = newsViewCellModel.titleNews
            textNewsLabel.attributedText = newsViewCellModel.textNews.attributedHtmlString
            
            dateLabel.text = newsViewCellModel.date
            
            if newsViewCellModel.index == 0 {
                setupFirstNews()
            } else {
                setupNormalNews()
            }
        }
    }

    
    // MARK: SETUP VIEWS
    
    private func setupNormalNews() {
        
        // PROPERTY VIEW
        
        contentView.backgroundColor = .white
        
        headerNewsLabel.textColor = .black
        headerNewsLabel.font = .boldSystemFont(ofSize: 17)
        headerNewsLabel.textAlignment = .left
        headerNewsLabel.numberOfLines = 0
        
        textNewsLabel.textColor = .black
        textNewsLabel.isHidden = true
        textNewsLabel.font = .systemFont(ofSize: 15)
  
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        dateLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 13)
         
       // CONSTRAINT
       
        self.addSubviews(image,headerNewsLabel,textNewsLabel,dateLabel)
       
        image.translatesAutoresizingMaskIntoConstraints = false
        headerNewsLabel.translatesAutoresizingMaskIntoConstraints = false
        textNewsLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        image.widthAnchor.constraint(equalToConstant: 72).isActive = true
        image.heightAnchor.constraint(equalToConstant: 72).isActive = true
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 88).isActive = true
        
        headerNewsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        headerNewsLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        headerNewsLabel.rightAnchor.constraint(equalTo: image.leftAnchor, constant: -16).isActive = true
        headerNewsLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -8).isActive = true
       
        dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    private func setupFirstNews() {
        
        // PROPERTY VIEW
        contentView.backgroundColor = .white
        
        headerNewsLabel.textColor = .black
        headerNewsLabel.font = .boldSystemFont(ofSize: 17)
        headerNewsLabel.textAlignment = .left
        headerNewsLabel.numberOfLines = 0
        
        textNewsLabel.textColor = .black
        textNewsLabel.textAlignment = .left
        textNewsLabel.numberOfLines = 0
        textNewsLabel.font = .systemFont(ofSize: 15)
        
        let string = textNewsLabel.text ?? ""
        var stringReady = ""
        var preCharacter = ""
        
        for character in string {
            if character == " " && preCharacter == "." {
                break
            } else {
                preCharacter = String(character)
                stringReady += String(character)
            }
        }
        
        textNewsLabel.text = stringReady
        
        
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        dateLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 13)
          
        // CONSTAINT
        
        self.addSubviews(image,headerNewsLabel,textNewsLabel,dateLabel)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        headerNewsLabel.translatesAutoresizingMaskIntoConstraints = false
        textNewsLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
         
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        image.heightAnchor.constraint(equalToConstant: 172).isActive = true
         
        headerNewsLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16).isActive = true
        headerNewsLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        headerNewsLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        
        textNewsLabel.topAnchor.constraint(equalTo: headerNewsLabel.bottomAnchor, constant: 8).isActive = true
        textNewsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        textNewsLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: textNewsLabel.bottomAnchor, constant: 8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        }
    
}
