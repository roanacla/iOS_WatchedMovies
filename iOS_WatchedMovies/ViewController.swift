//
//  ViewController.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 5/25/21.
//

import UIKit

class ViewController: UIViewController {

  var image: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let width = 300
    let height = 300
    self.image = UIImageView(frame: CGRect(x: view.center.x - CGFloat(width / 2),
                                           y: view.center.y - CGFloat(height / 2),
                                           width: 300,
                                           height: 300))
    self.view.addSubview(image)
    self.view.backgroundColor = .systemBackground
    self.getMovieData(movieName: "Army of the dead")
  }
  
  func getMovieData(movieName: String) {
    NetworkManager.shared.getMovieWithName(name: movieName) { (result) in
      switch result {
      case .success(let movie):
        print(movie.year)
        self.getMovieImage(posterLink: movie.poster)
      case .failure(let error):
        print(error.rawValue)
      }
    }
  }
  
  func getMovieImage(posterLink: String) {
    NetworkManager.shared.getImage(endpoint: posterLink) { (result) in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          self.image.image = UIImage(data: data)
        }
      case .failure(let error):
        print(error.rawValue)
      }
    }
  }


}

