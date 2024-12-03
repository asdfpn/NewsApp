//
//  NewsMainView.swift
//  NewsApp
//
//  Created by Puneet on 01/12/24.
//

import SwiftUI

struct MainView<ViewModel: NewsArticlesListViewModelProtocol>: View where ViewModel.ArticleType == Article {
    
    @StateObject var newsArticlesListViewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ArticlesListView(articles: articles)
                .overlay(overlayView)
                .onAppear {
                    if case .empty = newsArticlesListViewModel.phase {
                        Task {
                            await newsArticlesListViewModel.loadArticles()
                        }
                    }
                }
                .onChange(of: newsArticlesListViewModel.fetchTaskToken.category) { _ in
                    Task {
                        await refreshTask()
                    }
                }
                .refreshable(action: refreshTask)
                .navigationTitle(newsArticlesListViewModel.fetchTaskToken.category.text)
                .navigationBarItems(trailing: menu)
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch newsArticlesListViewModel.phase {
        case .empty:
            ProgressView()
        case .success(let articles) where articles.isEmpty:
            PlaceHolderView(text: "No Articles", image: nil)
        case .failure(let error):
            RetryView(text: error.localizedDescription) {
                Task {
                    await refreshTask()
                }
            }
        default:
            EmptyView()
        }
    }
    
    private var articles: [Article] {
        if case let .success(articles) = newsArticlesListViewModel.phase {
            return articles
        } else {
            return []
        }
    }
    
    private func refreshTask() async {
        newsArticlesListViewModel.fetchTaskToken = FetchTaskToken(
            category: newsArticlesListViewModel.fetchTaskToken.category,
            token: Date()
        )
        await newsArticlesListViewModel.loadArticles()
    }
    
    private var menu: some View {
        Menu {
            Picker("Category", selection: $newsArticlesListViewModel.fetchTaskToken.category) {
                ForEach(Categories.allCases, id: \.self) {
                    Text($0.text).tag($0)
                }
            }
        } label: {
            Image(systemName: "option")
                .imageScale(.large)
        }
    }
}


#Preview {
    MainView(newsArticlesListViewModel: NewsArticlesListViewModel(articles: Article.mock))
}
