//
//  GalleryCellModel.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 27.01.2023.
//

import Foundation

class GalleryViewCellModel: GalleryViewCellModelType {
    
    private let galleryModel: GalleryModel!
    
    var image: String {
        return galleryModel.image.original
    }
    
    var description: String {
        return galleryModel.description
    }
    
    var ID: String {
        return galleryModel.ID
    }
    
    init(galleryNews: GalleryModel) {
        self.galleryModel = galleryNews
    }
}
