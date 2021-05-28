//
//  Movie.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 5/25/21.
//

import Foundation


struct Movie: Codable {
  enum CodingKeys: String, CodingKey {
      case title = "Title"
      case year = "Year"
      case poster = "Poster"
  }
  
  var title: String = ""
  var year: String = ""
  var poster: String = ""
  var imdbID: String = ""
}


//{"Title":"Minari","Year":"2020","Rated":"PG-13","Released":"12 Feb 2021","Runtime":"115 min","Genre":"Drama","Director":"Lee Isaac Chung","Writer":"Lee Isaac Chung","Actors":"Alan S. Kim, Yeri Han, Noel Cho, Steven Yeun","Plot":"A Korean family starts a farm in 1980s Arkansas.","Language":"Korean, English","Country":"USA","Awards":"Won 1 Oscar. Another 105 wins & 211 nominations.","Poster":"https://m.media-amazon.com/images/M/MV5BNWEzOTNjNDgtZDhhYS00ODAxLWIzNGMtYjU3OGZhYmI3ZDU4XkEyXkFqcGdeQXVyMTAzNjk5MDI4._V1_SX300.jpg","Ratings":[{"Source":"Internet Movie Database","Value":"7.5/10"},{"Source":"Rotten Tomatoes","Value":"98%"},{"Source":"Metacritic","Value":"89/100"}],"Metascore":"89","imdbRating":"7.5","imdbVotes":"43,457","imdbID":"tt10633456","Type":"movie","DVD":"26 Feb 2021","BoxOffice":"$2,964,816","Production":"Plan B Entertainment","Website":"N/A","Response":"True"}
