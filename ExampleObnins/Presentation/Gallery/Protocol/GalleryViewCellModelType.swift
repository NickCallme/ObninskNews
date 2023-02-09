//
//  GalleryCellModelType.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 27.01.2023.
//

import Foundation

protocol GalleryViewCellModelType: AnyObject {
    
    var image: String { get }
    var description: String { get }
    var ID: String { get }
}
