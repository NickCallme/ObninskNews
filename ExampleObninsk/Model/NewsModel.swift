//
//  News.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 19.01.2023.
//

import Foundation

struct NewsModel: Decodable {
    
    var type: String
    var id: String
    var plus: String
    var minus: Int
    var tag: String?
    var tagID: String?
    var title: String
    var image: [ImageSize?]
    var author: String?
    var link: String
    var text: String
    var date: Int
    var reviewCount: Int
}

struct ImageSize: Decodable {
    var small: String?
    var original: String?
}
