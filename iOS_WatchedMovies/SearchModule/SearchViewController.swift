//
//  SearchViewController.swift
//  CIViperGenerator
//
//  Created by roanacla on 08.06.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import UIKit

protocol SearchViewControllerInterface: class {

}

class SearchViewController: UIViewController {
    var presenter: SearchPresenterInterface?
}

extension SearchViewController: SearchViewControllerInterface {

}
