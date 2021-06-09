//
//  File.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 6/8/21.
//

import Foundation

struct MovieDetail: Codable {
  enum CodingKeys: String, CodingKey {
    case title =  "Title"
    case year = "Year"
    case plot = "Plot"
    case poster = "Poster"
    case imdbID = "imdbID"
  }
  var title: String = ""
  var year: String = ""
  var plot: String = ""
  var poster: String = ""
  var imdbID: String = ""
}
