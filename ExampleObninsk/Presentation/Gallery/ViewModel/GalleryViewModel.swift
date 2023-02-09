//
//  GalleryViewModel.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 27.01.2023.
//

import Foundation

class GalleryViewModel: GalleryViewModelType {
    
    
    internal var networkService: APIService
    
    weak var view: GalleryViewController?
    
    private var galleryNews = [GalleryModel]() {
        didSet {
            updateData()
            print("Gallery news - \(galleryNews.count)")
        }
    }
    
    func updateData() {
        view?.upadteData()
    }
    
    func getGallery() {
        
        networkService.getGallery { result in
            self.galleryNews = result
        }
    }
    
    func getSkipGallery() {
        
        networkService.getSkipGallery(countSkip: galleryNews.count) { result in
            self.galleryNews.append(contentsOf: result)
        }
    }
    
    func numberOfItems() -> Int {
        
        return galleryNews.count
    }
    
    func createGalleryCellModel(indexPath: Int) -> GalleryViewCellModelType {
        
        return GalleryViewCellModel(galleryNews: galleryNews[indexPath])
    }
    
    func selectedCell(indexPath: Int) -> SelectedCellViewModelType {
        
        return SelectedCellViewModel(networkService: self.networkService, galleryCellModel: galleryNews[indexPath])
    }
    
    
    init(networkService: APIService, view: GalleryViewController) {
        
        self.networkService = networkService
        self.view = view
        
        getGallery()
    }
}
