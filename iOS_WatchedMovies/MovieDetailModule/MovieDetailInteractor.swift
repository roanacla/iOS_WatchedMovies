//
//  MovieDetailInteractor.swift
//  CIViperGenerator
//
//  Created by roanacla on 08.06.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import Foundation

protocol MovieDetailInteractorInterface: class {
  func fetchMovieDetail(imdbID: String)
  func fetchMoviePoster(movie: Movie)
  
}

class MovieDetailInteractor {
  weak var presenter: MovieDetailPresenterInterface?
}

extension MovieDetailInteractor: MovieDetailInteractorInterface {
  func fetchMovieDetail(imdbID: String) {
    NetworkManager.shared.getMovieByID(id: imdbID) { (result) in
      switch result {
      case .success(let movieDetail):
        self.presenter?.movieDetailFetched(movieDetail: movieDetail)
      case .failure(let error):
        print("🔴" + error.rawValue)
      }
    }
  }
  
  func fetchMoviePoster(movie: Movie) {
    NetworkManager.shared.getImage(for: movie) { (result) in
      switch result {
      case .success(let data):
        self.presenter?.moviePosterFetched(data: data)
      case .failure(let error):
        print("🔴" + error.rawValue)
      }
    }
  }
}
