//
//  ArticleService.swift
//  NewsApp
//
//  Created by Puneet on 30/11/24.
//

import Foundation
import Combine

struct ArticleService {
    
    static let shared = ArticleService()
    
        private init() {}
        
        private let session = URLSession.shared
        private let jsonDecoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return decoder
        }()
    
        func fetch(from category: Categories) -> AnyPublisher<[Article], Error> {
            let url = generateNewsURL(from: category)
            return NetworkingManager.download(url: url)
                .decode(type: NewsAPIResponse.self, decoder: jsonDecoder)
                .tryMap { response in
                    guard response.status == "ok" else {
                        throw NetworkingManager.NetworkingError.unknown
                    }
                    return response.articles ?? []
                }
                .eraseToAnyPublisher()
        }
        
        private func generateError(code: Int = 1, description: String) -> Error {
            NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
        }
        
        private func generateNewsURL(from category: Categories) -> URL {
            var url = "https://newsapi.org/v2/top-headlines?"
            url += "apiKey=\(Constants.apiKey)"
            url += "&language=en"
            url += "&category=\(category.rawValue)"
            return URL(string: url)!
        }
}
