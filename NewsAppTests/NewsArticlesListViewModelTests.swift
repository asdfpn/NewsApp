//
//  NewsArticlesListViewModelTests.swift
//  NewsAppTests
//
//  Created by Puneet on 02/12/24.
//

import XCTest

import XCTest
@testable import NewsApp

final class NewsArticlesListViewModelTests: XCTestCase {
    var mockViewModel: MockNewsArticlesListViewModel!
    
    override func setUp() {
        super.setUp()
        mockViewModel = MockNewsArticlesListViewModel(articles: nil, selectedCategory: .general)
    }
    
    override func tearDown() {
        mockViewModel = nil
        super.tearDown()
    }
    
    // Test Initialization with No Articles
    func testInitializationWithNoArticles() {
        //XCTAssertEqual(mockViewModel.phase, .empty, "Phase should be empty initially.")
        XCTAssertEqual(mockViewModel.fetchTaskToken.category, .general, "Default category should be general.")
    }
    
    // Test Initialization with Articles
    func testInitializationWithArticles() {
        let articles = Article.mock
        mockViewModel = MockNewsArticlesListViewModel(articles: articles, selectedCategory: .general)
        
        if case let .success(loadedArticles) = mockViewModel.phase {
            XCTAssertEqual(loadedArticles, articles, "Articles should match the provided data.")
        } else {
            XCTFail("Phase should be .success with provided articles.")
        }
    }
    
    // Test Fetching Articles
    func testLoadArticles() async {
        await mockViewModel.loadArticles()
        
        if case let .success(articles) = mockViewModel.phase {
            XCTAssertFalse(articles.isEmpty, "Articles should be loaded successfully.")
            XCTAssertEqual(articles.first?.title, "Lego and Formula 1 Roll Out Full Sets of Teams and Drivers", "Mock data should be returned.")
        } else {
            XCTFail("Phase should be .success after loading articles.")
        }
    }
    
    // Test Fetch Task Token Update
    func testFetchTaskTokenUpdate() {
        let newCategory: Categories = .technology
        let newToken = FetchTaskToken(category: newCategory, token: Date())
        
        mockViewModel.fetchTaskToken = newToken
        
        XCTAssertEqual(mockViewModel.fetchTaskToken.category, newCategory, "Category should be updated to technology.")
    }
    
    // Test Load Articles Failure
    func testLoadArticlesFailure() async {
        let failureViewModel = MockNewsArticlesListViewModelFailure()
        await failureViewModel.loadArticles()
        
        if case let .failure(error) = failureViewModel.phase {
            XCTAssertEqual((error as NSError).domain, "TestError", "Error domain should match the mock failure.")
        } else {
            XCTFail("Phase should be .failure after loading articles fails.")
        }
    }
}
