//
//  AboutsUsViewModelType.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 27.01.2023.
//

import Foundation

protocol AboutUsViewModelType: AnyObject {
    
    var networkService: APIService { get set }
    
    var text: String { get }
    
    func updateData()
    
    func getAboutUS()
}
