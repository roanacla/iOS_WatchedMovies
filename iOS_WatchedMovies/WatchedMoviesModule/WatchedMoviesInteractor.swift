//
//  WatchedMoviesInteractor.swift
//  CIViperGenerator
//
//  Created by roanacla on 01.07.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import Foundation

protocol WatchedMoviesInteractorInterface: class {
  func notifyViewDidLoad
}

class WatchedMoviesInteractor {
    weak var presenter: WatchedMoviesPresenterInterface?
}

extension WatchedMoviesInteractor: WatchedMoviesInteractorInterface {

}
