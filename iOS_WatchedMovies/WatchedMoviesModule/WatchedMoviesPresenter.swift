//
//  WatchedMoviesPresenter.swift
//  CIViperGenerator
//
//  Created by roanacla on 01.07.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import Foundation

protocol WatchedMoviesPresenterInterface: class {

}

class WatchedMoviesPresenter {

    unowned var view: WatchedMoviesViewControllerInterface
    let router: WatchedMoviesRouterInterface?
    let interactor: WatchedMoviesInteractorInterface?

    init(interactor: WatchedMoviesInteractorInterface, router: WatchedMoviesRouterInterface, view: WatchedMoviesViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension WatchedMoviesPresenter: WatchedMoviesPresenterInterface {

}
