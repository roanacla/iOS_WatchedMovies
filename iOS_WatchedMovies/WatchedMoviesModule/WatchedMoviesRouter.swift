//
//  WatchedMoviesRouter.swift
//  CIViperGenerator
//
//  Created by roanacla on 01.07.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import Foundation
import UIKit

protocol WatchedMoviesRouterInterface: class {

}

class WatchedMoviesRouter: NSObject {

    weak var presenter: WatchedMoviesPresenterInterface?

    static func setupModule() -> WatchedMoviesViewController {
        let vc = WatchedMoviesViewController()
        let interactor = WatchedMoviesInteractor()
        let router = WatchedMoviesRouter()
        let presenter = WatchedMoviesPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.presenter = presenter
        interactor.presenter = presenter
        return vc
    }
}

extension WatchedMoviesRouter: WatchedMoviesRouterInterface {

}

