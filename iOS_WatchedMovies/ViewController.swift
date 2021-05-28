//
//  ViewController.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 5/25/21.
//

import UIKit

class ViewController: UIViewController {

  //MARK: - Properties
  var image: UIImageView!
  var tableView: UITableView!
  
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUITableView()
    configureMainView()
  }
  
  
  //MARK: - Functions
  private func configureMainView() {
    self.view.backgroundColor = .systemBackground
  }
  
  private func configureUITableView() {
    self.tableView = UITableView(frame: view.bounds)
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  private func configureUIImageView() -> UIImageView {
    let width = 300
    let height = 300
    return UIImageView(frame: CGRect(x: view.center.x - CGFloat(width / 2),
                                     y: view.center.y - CGFloat(height / 2),
                                     width: 300,
                                     height: 300))
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

//MARK: - UITableView Delegates
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}

