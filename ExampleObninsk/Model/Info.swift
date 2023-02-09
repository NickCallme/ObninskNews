//
//  Info.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 26.01.2023.
//

import Foundation

struct Info {
    
    var mainImage: String
    var date: String
    var tag: String
    var townHeader: String
    var townText: String
    var textHeader: String
    var text: String
    var sightHeader: String
    var sights: [Sight]
}

struct Sight {
    
    var sightImage: String
    var sightText: String
}
