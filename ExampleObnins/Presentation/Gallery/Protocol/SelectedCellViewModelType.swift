//
//  SelectedViewCellModelType.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 27.01.2023.
//

import UIKit

protocol SelectedCellViewModelType: AnyObject {
    
    var networkService: APIService { get set }
    
    var image: String { get }
    var text: String { get }
    var id: String { get }
    
    func getNews(id: String)
    
    func createDetailMainViewModel() -> DetailMainViewModelType
}
