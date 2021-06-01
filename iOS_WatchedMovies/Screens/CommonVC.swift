//
//  ViewController.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 5/25/21.
//

import UIKit

class CommonVC: UIViewController {

  //MARK: - View Properties
  var tableView: UITableView!
  
  //MARK: - Properties
  var dataSource: [Movie] = []
  var totalResults = 0
  var hasMoreResults: Bool {
    return dataSource.count < totalResults ? true : false
  }
  var currentPage = 1
  var movieName = "batman"
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUITableView()
    configureMainView()
    getMovieData(movieName: movieName, page: currentPage)
  }
  
  
  //MARK: - Functions
  private func configureMainView() {
    self.view.backgroundColor = .systemBackground
  }
  
  private func configureUITableView() {
    self.tableView = UITableView(frame: view.bounds)
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseID)
    self.tableView.rowHeight = 60
    self.view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  func getMovieData(movieName: String, page: Int) {
    NetworkManager.shared.getMovieWithName(name: movieName, page: page) { (results) in
      switch results {
      case .success(let search):
        self.totalResults = Int(search.totalResults) ?? 0
        for movie in search.movies ?? [] {
          self.dataSource.append(movie)          
        }
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      case .failure(let error):
        print(error.rawValue)
      }
      
    }
  }
}

//MARK: - UITableView Delegates
extension CommonVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseID, for: indexPath) as? CustomTableViewCell
    let movie = dataSource[indexPath.row]
    cell?.setCell(movie: movie)
    return cell!
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if hasMoreResults {
      currentPage += 1
      getMovieData(movieName: movieName, page: currentPage)
    }
  }
}
