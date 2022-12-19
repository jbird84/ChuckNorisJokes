//
//  GifModel.swift
//  ChuckNorisJokes
//
//  Created by Kinney Kare on 12/19/22.
//

import Foundation

// MARK: - GIF
struct GIF: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let itemurl: String
    let url: String
}
