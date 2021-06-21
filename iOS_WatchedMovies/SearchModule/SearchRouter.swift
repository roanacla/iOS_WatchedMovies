//
//  SearchRouter.swift
//  CIViperGenerator
//
//  Created by roanacla on 08.06.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import Foundation
import UIKit
import CoreData

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
    let coreDataStack = (UIApplication.shared.delegate as! AppDelegate).coreDataStack
    let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    childContext.parent = coreDataStack.managedContext
    let movieDetailVC = MovieDetailRouter.setupModule(for: movie,context: childContext)
    self.navigationController?.pushViewController(movieDetailVC, animated: true)
  }
}

