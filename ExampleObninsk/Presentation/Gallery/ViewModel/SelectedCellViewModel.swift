//
//  SelectedViewModel.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 27.01.2023.
//

import UIKit

class SelectedCellViewModel: SelectedCellViewModelType {
    
    internal var networkService: APIService
    
    private var news: NewsModel?
    
    private let galleryCellModel: GalleryModel
    
    var image: String {
        return galleryCellModel.image.original
    }
    
    var text: String {
        return galleryCellModel.description
    }
    
    var id: String {
        return galleryCellModel.ID
    }
    
    func getNews(id: String) {
        
        networkService.getOneNews(id: galleryCellModel.ID) { result in
            self.news = result[0]
        }
    }
    
    func createDetailMainViewModel() -> DetailMainViewModelType {
        
        return DetailMainViewModel(news: news!)
    }
    
    init(networkService: APIService, galleryCellModel: GalleryModel) {
        self.networkService = networkService
        self.galleryCellModel = galleryCellModel
    }
}
