//
//  MainViewModelType.swift
//  ExampleObnins
//
//  Created by Nikita Kolmykov on 19.01.2023.
//

import Foundation

protocol MainViewModelType: AnyObject {
    
    var networkService: APIService { get set }
    
    func updateData()
    
    func numberOfRows() -> Int
    
    func getNews()
    
    func getHotNews()
    
    func getSkipNews()
    
    func getSkipHotNews()
    
    func createNewsСell(indexPath: Int)  -> NewsViewCellModelType
    
    func createHotNewsCell(indexPath: Int) -> NewsViewCellModelType
    
    func selectedNews(indexPath: IndexPath) -> DetailMainViewModelType
}
