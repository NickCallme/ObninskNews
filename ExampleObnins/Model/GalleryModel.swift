//
//  GalleryModel.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 27.01.2023.
//

import Foundation

struct GalleryModel: Decodable {
    
    var image: GallaryImage
    var description: String
    var ID: String
}

struct GallaryImage: Decodable {
    var small: String
    var original: String
}
