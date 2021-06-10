//
//  SearchPresenter.swift
//  CIViperGenerator
//
//  Created by roanacla on 08.06.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import Foundation

protocol SearchPresenterInterface: class {
  func notifyStartSearch(with name: String, page: Int)
  func notifySelectRow(row: Int)
  func notifyCancelSearch()
  func notifyGetNextPage()
  func notifyViewDidLoad()
  
  func appendMovies(_ movies: [Movie])
  func setTotalResults(_ total: Int )
  func increaseCurrentPage()
  func getMovies() -> [Movie]
}

class SearchPresenter {
  
  unowned var view: SearchViewControllerInterface
  let router: SearchRouterInterface?
  let interactor: SearchInteractorInterface?
  
  var movies: [Movie] = []
  var totalResults = 0
  var hasMoreResults: Bool {
    return movies.count < totalResults ? true : false
  }
  var currentPage = 1
  var movieName = ""
  
  
  init(interactor: SearchInteractorInterface, router: SearchRouterInterface, view: SearchViewControllerInterface) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

extension SearchPresenter: SearchPresenterInterface {
  func notifyStartSearch(with name: String, page: Int){
    self.movies.removeAll()
    self.movieName = name
    self.currentPage = page
    interactor?.fetchMovies(with: movieName, page: currentPage)
  }
  
  func notifyGetNextPage() {
    guard hasMoreResults else { return }
    currentPage += 1
    interactor?.fetchMovies(with: movieName, page: currentPage)
  }
  
  func notifySelectRow(row: Int){
    router?.performSegue(for: movies[row])
  }
  
  func notifyCancelSearch(){
    self.movies.removeAll()
    view.reloadTableView()
  }
  
  func notifyViewDidLoad() {
    guard let navController = view.getNavigationController() else { return }
    self.router?.setNavigationController(navController)
  }
  
  func appendMovies(_ movies: [Movie]) {
    self.movies.append(contentsOf: movies)
    view.reloadTableView()
  }
  
  func setTotalResults(_ total: Int ) {
    self.totalResults = total
  }
  
  func increaseCurrentPage() {
    self.currentPage += 1
  }
  
  func getMovies() -> [Movie] {
    return movies
  }
}
