//
//  Mock.swift
//  NewsAppTests
//
//  Created by Puneet on 02/12/24.
//

import Foundation
@testable import NewsApp

class MockNewsArticlesListViewModel: NewsArticlesListViewModelProtocol {
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var fetchTaskToken: FetchTaskToken
    
    required init(articles: [Article]? = nil, selectedCategory: Categories = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.fetchTaskToken = FetchTaskToken(category: selectedCategory, token: Date())
    }
    
    func loadArticles() async {
        // Simulate loading articles
        await Task.sleep(1 * 1_000_000_000)
        self.phase = .success(Article.mock)
    }
}

// Mock ViewModel for Failure
class MockNewsArticlesListViewModelFailure: NewsArticlesListViewModelProtocol {
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var fetchTaskToken: FetchTaskToken
    
    required init(articles: [Article]? = nil, selectedCategory: Categories = .general) {
        self.phase = .empty
        self.fetchTaskToken = FetchTaskToken(category: selectedCategory, token: Date())
    }
    
    func loadArticles() async {
        self.phase = .failure(NSError(domain: "TestError", code: 1, userInfo: nil))
    }
}
