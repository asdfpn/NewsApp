//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Puneet on 02/12/24.
//

import SwiftUI

struct ArticleDetailView: View {
    
    let article: Article
    @Environment(\.dismiss) var dismiss
    @State private var showWebView = false
    
    var body: some View {
        ZStack {

            StickyHeaderScrollView(image: {
                AsyncImage(url: article.imageURL) { value in
                    switch value {
                    case .empty:
                        HStack {
                            Spacer()
                            Image(systemName: "photo")
                                .imageScale(.large)
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
                .scaledToFill()
            }, title: {
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(LinearGradient(colors: [Color(UIColor.secondarySystemGroupedBackground), Color(UIColor.secondarySystemGroupedBackground), .clear], startPoint: .top, endPoint: .bottom))

                    VStack(spacing: 4) {
                        Text(article.title)
                            .font(.title2.weight(.semibold))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding(.top, 25)

                        Text(article.captionText)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(.horizontal)
                }
                .frame(height: 140)
            }, contents: {
                VStack(alignment: .leading) {
                    Text(article.descriptionText)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Author: \(article.authorText)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                    Spacer()
                    
                    Text("Read More..")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            showWebView = true
                        }
                        .sheet(isPresented: $showWebView) {
                            WebView(url: article.articleURL)
                                .edgesIgnoringSafeArea(.bottom)
                        }
                }
                .padding(.top, 1)
                .padding(.horizontal)
            }, maxHeight: 250)

            Button {
                withAnimation {
                    dismiss()
                }
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(Color.primary)
                        .frame(width: 23, height: 23)
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .offset(y: 50)
            .padding()
        }
    }
}

#Preview {
    ArticleDetailView(article: Article.mock[0])
}
