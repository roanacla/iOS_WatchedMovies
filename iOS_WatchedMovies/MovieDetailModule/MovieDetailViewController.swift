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
  func setMovieYear(with year: String)
  func setMoviePoster(with data: Data)
  func setMoviePlot(with plot: String)
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
    imageView.layer.cornerRadius = 0.5
    imageView.clipsToBounds = true
    presenter?.notifyViewLoaded()
  }
  
  //MARK: - IBActions
  @IBAction func saveInWatchedList(_ sender: Any) {
  }
  
  @IBAction func saveInToWatchList(_ sender: Any) {
    presenter?.notifySaveInToWatchList()
  }
  
}

extension MovieDetailViewController: MovieDetailViewControllerInterface {
  
  func setMovieTitle(with title: String) {
    nameLabel.text = title
  }
  
  func setMovieYear(with year: String) {
    yearLabel.text = year
  }
  
  func setMoviePoster(with data: Data) {
    DispatchQueue.main.async {
      self.imageView.image = UIImage(data: data)
    }
  }
  
  func setMoviePlot(with plot: String) {
    DispatchQueue.main.async {
      self.plotLabel.text = plot
    }
  }

}
