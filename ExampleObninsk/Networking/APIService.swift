//
//  APIService.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 25.01.2023.
//

import Foundation

final class APIService {
    
    func getNews(completion: @escaping (_: [NewsModel]) -> () ) {
        request(url: API.getNews, completion: completion)
    }
    
    func getHotNews(completion: @escaping ([NewsModel]) -> () ) {
        request(url: API.getHotNews, completion: completion)
    }
    
    func getGallery(completion: @escaping (_: [GalleryModel]) -> () ) {
        request(url: API.getGallery, completion: completion)
    }
    
    func getOneNews(id: String,completion: @escaping (_: [NewsModel]) -> () ) {
        request(url: API.getOneNews(id: id), completion: completion)
    }
    
    func getAboutUs(completion: @escaping (_: AboutUsModel) -> () ) {
        request(url: API.getAboutUs, completion: completion)
    }
    
    func getSkipNews(countSkip: Int, completion: @escaping (_: [NewsModel]) -> () ) {
        request(url: API.getSkipNews(countSkip: countSkip), completion: completion)
    }
    
    func getSkipHotNews(countSkip: Int, completion: @escaping (_: [NewsModel]) -> () ) {
        request(url: API.getSkipHotNews(countSkip: countSkip), completion: completion)
    }
    
    func getSkipGallery(countSkip: Int, completion: @escaping (_: [GalleryModel]) -> () ) {
        request(url: API.getSkipGallery(countSkip: countSkip), completion: completion)
    }
}

private extension APIService {
    
    private func request<T: Decodable>(url: API, completion: @escaping (_ result: T) -> () ) {
        
        guard let url = URL(string: url.path) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(data)
                }
            } catch {
                print("ERROR API --- \(error)")
            }
        }.resume()
    }
    
}
