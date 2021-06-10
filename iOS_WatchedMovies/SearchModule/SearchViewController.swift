//
//  SearchViewController.swift
//  CIViperGenerator
//
//  Created by roanacla on 08.06.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import UIKit

protocol SearchViewControllerInterface: class {
  func reloadTableView()
  func getNavigationController() -> UINavigationController?
}

class SearchViewController: UIViewController {
  
  //MARK: - View Components
  var tableView: UITableView!
  
  //MARK: - Properties
  var presenter: SearchPresenterInterface?
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter?.notifyViewDidLoad()
    self.configureUITableView()
    self.configureSearchBar()
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
  
  
}

extension SearchViewController: SearchViewControllerInterface {
  func reloadTableView() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  func getNavigationController() -> UINavigationController? {
    return self.navigationController
  }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.getMovies().count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseID, for: indexPath) as! CustomTableViewCell
    guard let movie = presenter?.getMovies()[indexPath.row] else {
      return UITableViewCell()
    }
    cell.setCell(movie: movie)
    return cell
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offsetY         = scrollView.contentOffset.y
    let contentHeight   = scrollView.contentSize.height
    let height          = scrollView.frame.size.height
    
    if offsetY > contentHeight - height {
      presenter?.notifyGetNextPage()
    }
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let favoriteAction = UIContextualAction(style: .normal,
                                            title: "Mark as favorite") { [weak self] (action, view, completion) in
//      let movie = self?.dataSource[indexPath.row]
//      self?.markAsFavorite(movie: movie)
      completion(true)
    }
    favoriteAction.backgroundColor = .systemGreen
    let conf = UISwipeActionsConfiguration(actions: [favoriteAction])
    
    return conf
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter?.notifySelectRow(row: indexPath.row)
  }
}

extension SearchViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let text = textField.text ?? ""
    presenter?.notifyStartSearch(with: text, page: 1)
    return true
  }
}

extension SearchViewController: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    presenter?.notifyCancelSearch()
  }
}
