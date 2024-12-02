//
//  NewsArticlesListViewModelProtocol.swift
//  NewsApp
//
//  Created by Puneet on 02/12/24.
//

import Foundation

protocol NewsArticlesListViewModelProtocol: ObservableObject {
    associatedtype ArticleType
    associatedtype CategoryType
    
    var phase: DataFetchPhase<[ArticleType]> { get set }
    var fetchTaskToken: FetchTaskToken { get set }
    
    init(articles: [ArticleType]?, selectedCategory: CategoryType)
    
    func loadArticles() async
}
