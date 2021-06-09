//
//  MovieDetailViewController.swift
//  CIViperGenerator
//
//  Created by roanacla on 08.06.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import UIKit

protocol MovieDetailViewControllerInterface: class {
  func setMovieTitle(with title: String)
}

class MovieDetailViewController: UIViewController {
  
  //Mark: - Outlets
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var yearLabel: UILabel!
  @IBOutlet var plotLabel: UITextView!
  
  //MARK: - Properties
  var presenter: MovieDetailPresenterInterface?
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  //MARK: - IBActions
  @IBAction func saveInWatchedList(_ sender: Any) {
  }
  
  @IBAction func saveInToWatchList(_ sender: Any) {
  }
  
}

extension MovieDetailViewController: MovieDetailViewControllerInterface {
  func setMovieTitle(with title: String) {
    nameLabel.text = title
  }
  
  
}
