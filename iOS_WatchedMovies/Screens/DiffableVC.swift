//
//  DiffableVC.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 5/31/21.
//

import UIKit

class DiffableVC: UIViewController {
  
  //MARK: - View Properties
  enum Section : CaseIterable { case main }
  
  var tableView: UITableView!
  var dataSource: UITableViewDiffableDataSource<Section, Movie>!
  var movies: [Movie] = []
  var totalResults: Int = 0
  var currentPage = 1
  var movieName = "avengers"
  var hasMoreResults: Bool {
    return movies.count < totalResults ? true : false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUITableView()
    
    configureMainView()
    configureDataSource()
    getMovieData(movieName: movieName, page: currentPage)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  //MARK: - Functions
  private func configureMainView() {
    self.view.backgroundColor = .systemBackground
  }
  
  private func configureUITableView() {
    self.tableView = UITableView(frame: view.bounds)
    self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseID)
    self.tableView.rowHeight = 60
    self.tableView.delegate = self
    
    self.view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  func configureDataSource() {
    dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, movie) -> UITableViewCell? in
      let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseID, for: indexPath) as? CustomTableViewCell
      cell?.setCell(movie: movie)
      return cell!
    })
  }
  
  func updateDataSource(newMovies: [Movie]) {
    var newSnapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
    newSnapshot.appendSections([.main])
    newSnapshot.appendItems(newMovies)
    DispatchQueue.main.async {
      self.dataSource.apply(newSnapshot,animatingDifferences: true)
    }
  }
  
  func getMovieData(movieName: String, page: Int) {
    NetworkManager.shared.getMovieWithName(name: movieName, page: page) { (results) in
      switch results {
      case .success(let search):
        self.totalResults = Int(search.totalResults) ?? 0
        self.movies.append(contentsOf: search.movies ?? [])
        self.updateDataSource(newMovies: self.movies)
      case .failure(let error):
        print(error.rawValue)
      }
    }
  }
  
}

extension DiffableVC: UITableViewDelegate {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if hasMoreResults {
      currentPage += 1
      getMovieData(movieName: movieName, page: currentPage)
    }
  }
}
