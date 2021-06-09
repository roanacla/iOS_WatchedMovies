//
//  SearchInteractor.swift
//  CIViperGenerator
//
//  Created by roanacla on 08.06.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import Foundation

protocol SearchInteractorInterface: class {

}

class SearchInteractor {
    weak var presenter: SearchPresenterInterface?
}

extension SearchInteractor: SearchInteractorInterface {

}
