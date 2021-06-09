//
//  MovieDetailPresenter.swift
//  CIViperGenerator
//
//  Created by roanacla on 08.06.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterInterface: class {
  func notifyViewLoaded()
  func movieDetailFetched(movieDetail: MovieDetail)
  func moviePosterFetched(data: Data)
}

class MovieDetailPresenter {
  
  unowned var view: MovieDetailViewControllerInterface
  let router: MovieDetailRouterInterface?
  let interactor: MovieDetailInteractorInterface?
  let movie: Movie
  
  init(interactor: MovieDetailInteractorInterface, router: MovieDetailRouterInterface, view: MovieDetailViewControllerInterface, movie: Movie) {
    self.view = view
    self.interactor = interactor
    self.router = router
    self.movie = movie
  }
}

extension MovieDetailPresenter: MovieDetailPresenterInterface {
  //MARK: - To Interactor
  func notifyViewLoaded() {
    interactor?.fetchMovieDetail(imdbID: movie.imdbID)
    interactor?.fetchMoviePoster(movie: movie)
    view.setMovieTitle(with: movie.title)
    view.setMovieYear(with: movie.year)
  }
  
  //MARK: - To View
  func movieDetailFetched(movieDetail: MovieDetail) {
    view.setMoviePlot(with: movieDetail.plot)
  }
  
  func moviePosterFetched(data: Data) {
    view.setMoviePoster(with: data)
  }
  
  
}
