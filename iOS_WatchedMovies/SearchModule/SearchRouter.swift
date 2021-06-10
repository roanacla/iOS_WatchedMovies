//
//  SearchRouter.swift
//  CIViperGenerator
//
//  Created by roanacla on 08.06.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import Foundation
import UIKit

protocol SearchRouterInterface: class {
  func setNavigationController(_ navController: UINavigationController)
  func performSegue(for movie: Movie)
}

class SearchRouter: NSObject {
  
  weak var presenter: SearchPresenterInterface?
  weak var navigationController: UINavigationController?
  
  static func setupModule() -> SearchViewController {
    let vc = SearchViewController()
    let interactor = SearchInteractor()
    let router = SearchRouter()
    let presenter = SearchPresenter(interactor: interactor, router: router, view: vc)
    
    vc.presenter = presenter
    router.presenter = presenter
    interactor.presenter = presenter
    return vc
  }
}

extension SearchRouter: SearchRouterInterface {
  func setNavigationController(_ navController: UINavigationController) {
    self.navigationController = navController
  }
  
  func performSegue(for movie: Movie) {
    let movieDetailVC = MovieDetailRouter.setupModule(for: movie)
    self.navigationController?.pushViewController(movieDetailVC, animated: true)
  }
}

