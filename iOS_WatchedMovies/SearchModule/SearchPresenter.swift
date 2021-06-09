//
//  SearchPresenter.swift
//  CIViperGenerator
//
//  Created by roanacla on 08.06.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import Foundation

protocol SearchPresenterInterface: class {

}

class SearchPresenter {

    unowned var view: SearchViewControllerInterface
    let router: SearchRouterInterface?
    let interactor: SearchInteractorInterface?

    init(interactor: SearchInteractorInterface, router: SearchRouterInterface, view: SearchViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchPresenterInterface {

}
