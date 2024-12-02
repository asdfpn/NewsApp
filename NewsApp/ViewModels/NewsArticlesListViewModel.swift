//
//  NewsArticlesListViewModel.swift
//  NewsApp
//
//  Created by Puneet on 01/12/24.
//

import Foundation
import Combine

class NewsArticlesListViewModel: ObservableObject {
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var fetchTaskToken: FetchTaskToken
    private let articleService = ArticleService.shared
    private var cancellables = Set<AnyCancellable>()

    required init(articles: [Article]? = nil, selectedCategory: Categories = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.fetchTaskToken = FetchTaskToken(category: selectedCategory, token: Date())
    }
    
    func loadArticles() {
        phase = .empty

        articleService.fetch(from: fetchTaskToken.category)
            .sink(receiveCompletion: { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.phase = .failure(error)
                        print("[❌] Error loading articles: \(error.localizedDescription)")
                    }
                }
            }, receiveValue: { [weak self] articles in
                DispatchQueue.main.async {
                    self?.phase = .success(articles)
                }
            })
            .store(in: &cancellables)
    }
}


enum DataFetchPhase<T> {
    
    case empty
    case success(T)
    case failure(Error)
}

struct FetchTaskToken: Equatable {
    var category: Categories
    var token: Date
}
