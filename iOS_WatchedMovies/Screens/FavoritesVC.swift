//
//  FavoritesVC.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 6/7/21.
//

import UIKit

class FavoritesVC: UIViewController {
  
  var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureTableView()
  }
  
  func configureTableView() {
    self.tableView = UITableView()
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      self.tableView.topAnchor.constraint(equalTo: view.topAnchor),
      self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    ])
  }
}
