//
//  Article.swift
//  NewsApp
//
//  Created by Puneet on 28/11/24.
//

import Foundation

let relativeDateTimeFormatter = RelativeDateTimeFormatter()

// MARK: - NewsAPIResponse
struct NewsAPIResponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    let code, message: String?
}

// MARK: - Article
struct Article: Codable, Equatable, Identifiable {
    
    // This id will be unique and auto generated from client side to avoid clashing of Identifiable in a List as NewsAPI response doesn't provide unique identifier
    let id = UUID()

    let source: Source
    let title: String
    let url: String
    let publishedAt: Date
    
    let author: String?
    let description: String?
    let urlToImage: String?
    
    
    enum CodingKeys: String, CodingKey {
        case source
        case title
        case url
        case publishedAt
        case author
        case description
        case urlToImage
    }
    
    var authorText: String {
        author ?? "Unknown"
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var captionText: String {
        "\(source.name) ‧ \(relativeDateTimeFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
    
    var articleURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
    
}

extension Article {
    
    static var previewData: [Article] {
        let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(NewsAPIResponse.self, from: data)
        return apiResponse.articles ?? []
    }
    
}

// MARK: - Source
struct Source: Codable, Equatable {
    let name: String
}

extension Article {
    
    static var mock: [Article] {
        [Article(
            source: Source(name: "Wired"),
            title: "Lego and Formula 1 Roll Out Full Sets of Teams and Drivers",
            url: "https://www.wired.com/story/lego-and-formula-1-sets/",
            publishedAt: Date.now.addingTimeInterval(-15000),
            author: "Adrienne So",
            description: "In 2025, you will be able to recreate full Formula 1 Grands Prix in your living room, complete with Lego cars, drivers, and garages.",
            urlToImage: "https://media.wired.com/photos/673f67eb4c158487100880f9/191:100/w_1280,c_limit/Lego-Formula-1-Set-Lifestyle_2-SOURCE-Lego.jpg"
        ),
         Article(
             source: Source(name: "The Verge"),
             title: "The Verge’s guide to the 2024 presidential election",
             url: "https://www.theverge.com/24279527/2024-presidential-election-guide-tech-policy",
             publishedAt: Date.now.addingTimeInterval(-15000),
             author: "The Verge Staff",
             description: "Vice President Kamala Harris is taking on former President Donald Trump. The election will determine the future of everything from electric cars to the entire legal system to to our democracy itself.",
             urlToImage: "https://cdn.vox-cdn.com/thumbor/xG8M1zPOXmzE0IyEhJkVRhrpB_Y=/0x0:2040x1360/1200x628/filters:focal(1105x362:1106x363)/cdn.vox-cdn.com/uploads/chorus_asset/file/25693279/247224_Election_Package__Mr.Nelson_design_HUB.jpg"
             
         )]
    }
}
