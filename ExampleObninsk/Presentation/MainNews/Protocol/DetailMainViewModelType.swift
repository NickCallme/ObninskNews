//
//  DetailMainViewModelType.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 26.01.2023.
//

import Foundation

protocol DetailMainViewModelType: AnyObject {
    
    var image: String { get }
    var date: String { get }
    var tag: String { get }
    var title: String { get }
    var text: String { get }
    var author: String { get }
    var reviewCount: String { get }
}
