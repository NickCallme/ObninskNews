//
//  GallaryViewModelType.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 27.01.2023.
//

import Foundation

protocol GalleryViewModelType: AnyObject {
    
    var networkService: APIService { get set }
    
    func updateData()
    
    func getGallery()
    
    func getSkipGallery()
    
    func numberOfItems() -> Int
    
    func createGalleryCellModel(indexPath: Int) -> GalleryViewCellModelType
    
    func selectedCell(indexPath: Int) -> SelectedCellViewModelType
    
}
