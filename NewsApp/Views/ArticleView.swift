//
//  ArticleView.swift
//  NewsApp
//
//  Created by Puneet on 28/11/24.
//

import SwiftUI

struct ArticleView: View {
    
    @EnvironmentObject var bookmarkViewModel: BookmarkViewModel
    
    let article: Article
    
    var body: some View {
        imageView
        
        contentView
    }
    
    private var imageView: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: article.imageURL) { value in
                
                switch value {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure(_):
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                            .imageScale(.large)
                        Spacer()
                    }
                @unknown default:
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                            .imageScale(.large)
                        Spacer()
                    }
                }
            }
            .frame(minHeight: 200, maxHeight: 300)
            .background(Color.gray.opacity(0.3))
            .clipped()
        }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(article.title)
                .font(.headline)
                .lineLimit(3)
            
            Text(article.descriptionText)
                .font(.subheadline)
                .lineLimit(2)
            
            HStack {
                Text(article.captionText)
                    .lineLimit(1)
                    .foregroundColor(.secondary)
                    .font(.caption)
                
                Spacer()
                
                Button(action: {
                    toggleBookmark(for: article)
                }, label: {
                    Image(systemName: bookmarkViewModel.isBookmarked(for: article) ? "bookmark.fill" : "bookmark")
                })
                .buttonStyle(BorderedButtonStyle())
                
                Button(action: {
                    shareContent(url: article.articleURL)
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                })
                .buttonStyle(BorderedButtonStyle())
                
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    func shareContent(url: URL) {
        
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    
    private func toggleBookmark(for article: Article) {
        if bookmarkViewModel.isBookmarked(for: article) {
            bookmarkViewModel.removeBookmark(for: article)
        } else {
            bookmarkViewModel.addBookmark(for: article)
        }
    }
}

#Preview {
    
    NavigationView {
        List {
            ArticleView(article: Article.mock[1])
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
    }
    .environmentObject(BookmarkViewModel.shared)
}
