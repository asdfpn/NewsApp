//
//  Category.swift
//  NewsApp
//
//  Created by Puneet on 30/11/24.
//

import Foundation

enum Categories: String, CaseIterable, Identifiable {
    case general
    case business
    case technology
    case entertainment
    case sports
    case science
    case health
    
    var id: Self { self }
    
    var text: String {
        if self == .general {
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
}
