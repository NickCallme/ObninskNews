//
//  DetailMainViewModel.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 26.01.2023.
//

import Foundation

class DetailMainViewModel: DetailMainViewModelType {
    
    private var news: NewsModel
    
    var image: String {
        return news.image[0]?.original ?? ""
    }
    
    var date: String {
        let date = Date(timeIntervalSince1970: Double(news.date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let formatteDate = dateFormatter.string(from: date)
        return formatteDate
    }
    
    var tag: String {
        return news.tag ?? ""
    }
    
    var title: String {
        return news.title
    }
    
    var text: String {
        return news.text
    }
    
    var author: String {
        return news.author ?? ""
    }
    
    var reviewCount: String {
        return String(news.reviewCount)
    }
    
    init(news: NewsModel) {
        
        self.news = news
    }
}
