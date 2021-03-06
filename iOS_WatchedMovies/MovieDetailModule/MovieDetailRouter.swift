//
//  MovieDetailRouter.swift
//  CIViperGenerator
//
//  Created by roanacla on 08.06.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol MovieDetailRouterInterface: class {
  
}

class MovieDetailRouter: NSObject {
  
  weak var presenter: MovieDetailPresenterInterface?
  
  static func setupModule(for movie: Movie,
                          context: NSManagedObjectContext) -> MovieDetailViewController {
    let vc = MovieDetailViewController()
    let interactor = MovieDetailInteractor()
    interactor.context = context
    let router = MovieDetailRouter()
    let presenter = MovieDetailPresenter(interactor: interactor, router: router, view: vc, movie: movie)
    
    vc.presenter = presenter
    router.presenter = presenter
    interactor.presenter = presenter
    return vc
  }
}

extension MovieDetailRouter: MovieDetailRouterInterface {
  
}

