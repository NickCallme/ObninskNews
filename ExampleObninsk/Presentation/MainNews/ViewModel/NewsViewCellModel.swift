//
//  TableViewCellModel.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 25.01.2023.
//

import Foundation
import UIKit

class NewsViewCellModel: NewsViewCellModelType {
    
    var news: NewsModel
    
    var image: String {
        return news.image[0]!.original!
    }
    var titleNews: String {
        return news.title
    }
    
    var textNews: String {
        return news.text
    }
    
    var date: String {
        let date = Date(timeIntervalSince1970: Double(news.date))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM"
        let formatteDate = dateFormatter.string(from: date)
        return formatteDate
    }
    
    var index: Int
    
    init(news: NewsModel, index: Int) {
        
        self.news = news
        self.index = index
    }
    
}
