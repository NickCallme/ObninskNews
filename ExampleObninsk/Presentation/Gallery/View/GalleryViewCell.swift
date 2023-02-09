//
//  GalleryViewCell.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 27.01.2023.
//

import UIKit
import Kingfisher

class GalleryViewCell: UICollectionViewCell {
    
    private var imageView = UIImageView()
    private var descrip = String()
    private var id = String()
    
    
    var cellViewModel: GalleryViewCellModelType? {
        didSet {
            guard let model = cellViewModel else { return }
            imageView.kf.setImage(with: URL(string:model.image))
            descrip = model.description
            id = model.ID
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        // PROPERTY VIEW
        
        contentView.backgroundColor = .white
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        // CONSTATINT
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
