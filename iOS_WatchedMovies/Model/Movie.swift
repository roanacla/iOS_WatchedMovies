//
//  Movie.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 5/25/21.
//

import Foundation


struct Movie: Codable, Hashable {
  enum CodingKeys: String, CodingKey {
      case title = "Title"
      case year = "Year"
      case poster = "Poster"
      case imdbID = "imdbID"
  }
  
  var title: String = ""
  var year: String = ""
  var poster: String = ""
  var imdbID: String = ""
  
  static func createEntity(movie: Movie) -> Entity {
    let entity = Entity()
    entity.name = movie.title
    entity.year = movie.year
    entity.posterURLString = movie.poster
    entity.imdbID = movie.imdbID
    
    return entity
  }
}
