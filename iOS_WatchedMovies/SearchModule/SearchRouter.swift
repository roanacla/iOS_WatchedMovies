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

}

class SearchRouter: NSObject {

    weak var presenter: SearchPresenterInterface?

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

}

