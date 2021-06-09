//
//  MovieDetailPresenter.swift
//  CIViperGenerator
//
//  Created by roanacla on 08.06.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterInterface: class {
}

class MovieDetailPresenter {
  
  unowned var view: MovieDetailViewControllerInterface
  let router: MovieDetailRouterInterface?
  let interactor: MovieDetailInteractorInterface?
  
  init(interactor: MovieDetailInteractorInterface, router: MovieDetailRouterInterface, view: MovieDetailViewControllerInterface) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

extension MovieDetailPresenter: MovieDetailPresenterInterface {
}
