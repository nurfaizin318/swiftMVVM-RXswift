//
//  ArticleModel.swift
//  swiftTest
//
//  Created by MacBook on 17/01/23.
//

import Foundation

struct ArticleModel: Codable {
    let status: String
//    let totalResults: Int?
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}

// MARK: - Source
struct Source: Codable {
    let name: String

}


