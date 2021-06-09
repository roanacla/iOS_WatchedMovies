//
//  Search.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 6/8/21.
//

import Foundation

struct Search: Codable {
  enum CodingKeys: String, CodingKey {
    case movies = "Search"
    case response = "Response"
    case totalResults = "totalResults"
  }
  var movies: [Movie]? = []
  var totalResults: String = "0"
  var response: String = "false"
}
