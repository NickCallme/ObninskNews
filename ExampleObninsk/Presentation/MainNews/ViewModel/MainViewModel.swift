//
//  MainViewModel.swift
//  ExampleObnins
//
//  Created by Nikita Kolmykov on 19.01.2023.
//

import Foundation

class MainViewModel: MainViewModelType {

    var networkService: APIService
    
    weak var view: MainViewController?
    
    private var news = [NewsModel]() {
        didSet {
            updateData()
        }
    }
    
    func updateData() {
        view?.updateData()
    }
    
    func numberOfRows() -> Int {
        
        return news.count
    }
    
    
    
    func getNews() {
        
        networkService.getNews { result in
            self.news = result
        }
    }
    
    func getHotNews() {
        
        networkService.getHotNews { result in
            self.news = result
        }
    }
    
    func getSkipNews() {
        
        networkService.getSkipNews(countSkip: news.count) { result in
            self.news.append(contentsOf: result)
        }
    }
    
    func getSkipHotNews() {
        
        networkService.getSkipHotNews(countSkip: news.count) { result in
            self.news.append(contentsOf: result)
        }
    }
    
    func createNewsСell(indexPath: Int)  -> NewsViewCellModelType {
        
        // защита от несвоевременной подгрузки
        var index = indexPath
        if indexPath >= (news.count - 1) { index = news.count - 1 }
        
        return NewsViewCellModel(news: news[index], index: index)
    }
    
    func createHotNewsCell(indexPath: Int) -> NewsViewCellModelType {
        
        // защита от несвоевременной подгрузки
        var index = indexPath
        if indexPath >= (news.count - 1) { index = news.count - 1 }
        
        return NewsViewCellModel(news: news[index], index: index + 1)
    }
    
    func selectedNews(indexPath: IndexPath) -> DetailMainViewModelType {
        return DetailMainViewModel(news: news[indexPath.row])
    }
    
    init(networkService: APIService, view: MainViewController) {
        
        self.networkService = networkService
        self.view = view
        
        getNews()
    }
    
}
