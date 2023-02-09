//
//  AboutUsViewModel.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 27.01.2023.
//

import Foundation

class AboutUsViewModel: AboutUsViewModelType {
    
    var networkService: APIService
    
    weak var view: AboutUsViewController?
    
    private var aboutUsModel: AboutUsModel? {
        didSet {
            updateData()
        }
    }
    
    var text: String {
        return aboutUsModel?.text ?? "example"
    }
    
    func updateData() {
        view?.updateData(text: text)
    }
    
    func getAboutUS() {
        
        networkService.getAboutUs { result in
            self.aboutUsModel = result
        }
    }
    
    init(networkService: APIService, view: AboutUsViewController) {
        self.networkService = networkService
        self.view = view
        
        getAboutUS()
    }
}
