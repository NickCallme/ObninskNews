//
//  NetworkManager.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 25.01.2023.
//

import Foundation

protocol TargetType {
    
    var baseURL: URL { get }
    
    var path: String { get }
    
    var method: Method { get }
}

enum Method {
    
    case GET
    case POST
    
}

enum API {
    
    static private let host = "https://obninsk.name/api.php?get="
    
    //MAIN
    case getNews
    case getHotNews
    //Gallery
    case getGallery
    case getOneNews(id: String)
    //AboutUs
    case getAboutUs
    // Подгрузка новостей
    case getSkipNews(countSkip: Int)
    // Подгрузка горячих новостей
    case getSkipHotNews(countSkip: Int)
    // Подгрузка галереи
    case getSkipGallery(countSkip: Int)
    
}

extension API: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: API.host) else { fatalError() }
        return url
    }
    
    var path: String {
        
        switch self {
        case .getNews:
            return API.host + "news&limit=20"
        case.getHotNews:
            return API.host + "news&show=hot&limit=20"
        case .getGallery:
            return API.host + "gallery&limit=25"
        case .getOneNews(let id):
            return API.host + "post&ID=" + id
        case .getAboutUs:
            return API.host + "about"
        case .getSkipNews(let countSkip):
            return API.host + "news&skip=\(countSkip)&limit=20"
        case .getSkipHotNews(let countSkip):
            return API.host + "news&show=hot&skip=\(countSkip)&limit=20"
        case .getSkipGallery(let countSkip):
            return API.host + "gallery&skip=\(countSkip)&limit=25"
        }
    }
    
    var method: Method {
        switch self {
        case .getNews:
            return .GET
        case .getHotNews:
            return .GET
        case .getGallery:
            return .GET
        case .getOneNews(_):
            return .GET
        case .getAboutUs:
            return .GET
        case .getSkipNews(_):
            return .GET
        case .getSkipHotNews(_):
            return .GET
        case .getSkipGallery(_):
            return .GET
        }
    }
    
}
