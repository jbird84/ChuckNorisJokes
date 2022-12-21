//
//  GifModel.swift
//  ChuckNorisJokes
//
//  Created by Kinney Kare on 12/19/22.
//

import Foundation

// MARK: - Content
struct Content: Decodable {
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let media_formats: MediaFormats
}

// MARK: - MediaFormats
struct MediaFormats: Decodable {
    let gif: GIF
}

// MARK: - GIF
struct GIF: Decodable {
    let url: String
}
