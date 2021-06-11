//
//  MovieDetailInteractor.swift
//  CIViperGenerator
//
//  Created by roanacla on 08.06.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailInteractorInterface: class {
  func fetchMovieDetail(imdbID: String)
  func fetchMoviePoster(movie: Movie)
  func storeMovieDetail()
}

class MovieDetailInteractor {
  weak var presenter: MovieDetailPresenterInterface?
  var posterData: Data?
  var movieDetail: MovieDetail?
  var coreDataStack: CoreDataStack? {
    (UIApplication.shared.delegate as! AppDelegate).coreDataStack
  }
  
  private func storeMovieDetailInJson() {
    do {
      guard let movieDetail = movieDetail else { return }
      try DataFileManager.shared.storeToWatchList(movieDetails: [movieDetail])
      guard let posterData = posterData else { return }
      _ = DataFileManager.shared.storeMoviePoster(movieDetail: movieDetail, posterData: posterData)
    } catch {
      print("🔴" + error.localizedDescription)
    }
  }
  
  private func storeMovieDetailInCoreData() {
    guard let context = coreDataStack?.managedContext else { return }
    guard let movieDetail = movieDetail else { return }
    let entity = Entity(context: context)
    entity.imdbID = movieDetail.imdbID
    entity.name = movieDetail.title
    entity.year = movieDetail.year
    entity.plot = movieDetail.plot
    entity.posterURLString = movieDetail.poster
    coreDataStack?.saveContext()
  }
  
  private func storeMoviePoster() {
    guard let movieDetail = movieDetail else { return }
    guard let posterData = posterData else { return }
    _ = DataFileManager.shared.storeMoviePoster(movieDetail: movieDetail, posterData: posterData)
  }
}

extension MovieDetailInteractor: MovieDetailInteractorInterface {
  func fetchMovieDetail(imdbID: String) {
    NetworkManager.shared.getMovieByID(id: imdbID) { (result) in
      switch result {
      case .success(let movieDetail):
        self.movieDetail = movieDetail
        self.presenter?.movieDetailFetched(movieDetail: movieDetail)
      case .failure(let error):
        print("🔴" + error.rawValue)
      }
    }
  }
  
  func fetchMoviePoster(movie: Movie) {
    NetworkManager.shared.getImage(imdbID: movie.imdbID, posterURLString: movie.poster) { (result) in
      switch result {
      case .success(let data):
        self.posterData = data
        self.presenter?.moviePosterFetched(data: data)
      case .failure(let error):
        print("🔴" + error.rawValue)
      }
    }
  }
  
  func storeMovieDetail() {
    self.storeMovieDetailInCoreData()
    self.storeMoviePoster()
  }
}
