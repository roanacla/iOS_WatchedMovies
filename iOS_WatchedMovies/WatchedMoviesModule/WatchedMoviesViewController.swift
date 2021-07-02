//
//  WatchedMoviesViewController.swift
//  CIViperGenerator
//
//  Created by roanacla on 01.07.2021.
//  Copyright © 2021 roanacla. All rights reserved.
//

import UIKit

protocol WatchedMoviesViewControllerInterface: AnyObject {

}

class WatchedMoviesViewController: UIViewController {
  
  @IBOutlet weak var test: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    
  }
  var presenter: WatchedMoviesPresenterInterface?
}

extension WatchedMoviesViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  
}
extension WatchedMoviesViewController: WatchedMoviesViewControllerInterface {

}


