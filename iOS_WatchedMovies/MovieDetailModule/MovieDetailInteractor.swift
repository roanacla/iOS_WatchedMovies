//
//  MovieDetailInteractor.swift
//  CIViperGenerator
//
//  Created by roanacla on 08.06.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import Foundation

protocol MovieDetailInteractorInterface: class {
  
}

class MovieDetailInteractor {
  weak var presenter: MovieDetailPresenterInterface?
}

extension MovieDetailInteractor: MovieDetailInteractorInterface {
//  func fetchMovie() {
//    NetworkManager.shared.getMovieByID(id: self.imdbID) { (result) in
//      switch result {
//      case .success(let movieDetail):
//        self.movieDetail = movieDetail
//      case .failure(let error):
//        print("🔴" + error.rawValue)
//      }
//    }
//  }
}
