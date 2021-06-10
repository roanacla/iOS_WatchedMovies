//
//  SearchInteractor.swift
//  CIViperGenerator
//
//  Created by roanacla on 08.06.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import Foundation

protocol SearchInteractorInterface: class {
  //Input
  func fetchMovies(with name: String, page: Int)
}

class SearchInteractor {
    weak var presenter: SearchPresenterInterface?
}

extension SearchInteractor: SearchInteractorInterface {
  //MARK: - Input
  func fetchMovies(with name: String, page: Int){
    NetworkManager.shared.getMovieWithName(name: name, page: page) { (results) in
      switch results {
      case .success(let search):
        let totalResult = Int(search.totalResults) ?? 0
        self.presenter?.setTotalResults(totalResult)
        self.presenter?.appendMovies(search.movies ?? [])
      case .failure(let error):
        print(error.rawValue)
      }
    }
  }
}
