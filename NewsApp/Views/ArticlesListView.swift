//
//  ArticlesListView.swift
//  NewsApp
//
//  Created by Puneet on 29/11/24.
//

import SwiftUI

struct ArticlesListView: View {
    
    let articles: [Article]
    @State private var selectedArticle: Article?
    
    var body: some View {
        List {
            ForEach(articles) { article in
                ArticleView(article: article)
                    .onTapGesture {
                        selectedArticle = article
                    }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .fullScreenCover(item: $selectedArticle) { selectedArticle in
            ArticleDetailView(article: selectedArticle)
        }
    }
}

#Preview {
    ArticlesListView(articles: Article.mock)
}
