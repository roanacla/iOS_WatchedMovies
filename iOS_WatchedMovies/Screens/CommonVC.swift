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
  var movieName = ""
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUITableView()
    configureMainView()
    configureSearchBar()
  }
  
  
  //MARK: - Configure View
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
  
  private func configureSearchBar() {
    let searchController = UISearchController()
    searchController.searchBar.placeholder = "Search by movie title"
    searchController.searchBar.searchTextField.delegate = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
    
    navigationItem.searchController = searchController
  }
  
  //MARK: - Data functions
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
  
  //MARK: - Functions
  func markAsFavorite(movie: Movie?) {
    guard let movie = movie else { return }
    print(movie)
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
    let offsetY         = scrollView.contentOffset.y
    let contentHeight   = scrollView.contentSize.height
    let height          = scrollView.frame.size.height
    
    if offsetY > contentHeight - height {
      guard hasMoreResults else { return }
      currentPage += 1
      self.getMovieData(movieName: movieName, page: currentPage)
    }
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let favoriteAction = UIContextualAction(style: .normal,
                                            title: "Mark as favorite") { [weak self] (action, view, completion) in
      let movie = self?.dataSource[indexPath.row]
      self?.markAsFavorite(movie: movie)
      completion(true)
    }
    favoriteAction.backgroundColor = .systemGreen
    let conf = UISwipeActionsConfiguration(actions: [favoriteAction])
    
    return conf
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let movie = dataSource[indexPath.row]
    let movieDetailVC = MovieDetailRouter.setupModule(for: movie)
    navigationController?.pushViewController(movieDetailVC, animated: true)
  }
}

//MARK: - UISearch
extension CommonVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let text = textField.text ?? ""
    movieName = text
    currentPage = 1
    dataSource.removeAll()
    getMovieData(movieName: text, page: currentPage)
    return true
  }
}

extension CommonVC: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    self.dataSource.removeAll()
    tableView.reloadData()
  }
}
