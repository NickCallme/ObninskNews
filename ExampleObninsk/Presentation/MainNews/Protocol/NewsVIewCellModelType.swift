//
//  TableVIewCellType.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 25.01.2023.
//

import Foundation

protocol NewsViewCellModelType: AnyObject {
    
    var image: String { get }
    var titleNews: String { get }
    var textNews: String { get }
    var date: String { get }
    var index: Int { get }
}
