//
//  DiffCollVC.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 6/8/21.
//

import UIKit

class ToWatchVC: UIViewController {
  
  
  //MARK: - View Components
  var collectionView: UICollectionView!
  
  //MARK: - Properties
  var movies: [Movie] = []
  var movieName: String = ""
  var currentPage: Int = 1
  var totalResults: Int = 0
  var hasMoreResults: Bool {
    return movies.count < totalResults ? true : false
  }
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureSearchBar()
    configureCollectionView()
  }
  
  //MARK: - View Conf Functions
  
  func configureSearchBar() {
    navigationItem.searchController = UISearchController()
    navigationItem.searchController?.searchBar.placeholder = "Search by the movie name"
    navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController?.searchBar.delegate = self
  }
  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CollectionViewLayout.createThreeColumnFlowLayout(in: view))
    collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseID)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .systemBackground
    view.addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  //MARK: - Data Functions
  func requestData(movieName: String, page: Int, completion: @escaping () -> ()) {
    NetworkManager.shared.getMovieWithName(name: movieName, page: page) { (result) in
      switch result {
      case .success(let search):
        self.movies.append(contentsOf: search.movies ?? [])
        self.totalResults = Int(search.totalResults) ?? 0
        completion()
      case .failure(let error):
        print("🔴 " + error.localizedDescription)
      }
    }
  }
  
}

//MARK: CollectionViewDelegate

extension ToWatchVC: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseID, for: indexPath) as! CollectionViewCell
    let movie = movies[indexPath.row]
    cell.set(movie: movie)
    return cell
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offsetY         = scrollView.contentOffset.y
    let contentHeight   = scrollView.contentSize.height
    let height          = scrollView.frame.size.height
    
    if offsetY > contentHeight - height {
      guard hasMoreResults else { return }
      currentPage += 1
      self.requestData(movieName: movieName, page: currentPage) {
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    }
  }
}


//MARK: - Search Delegate
extension ToWatchVC: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    print("Search")
    currentPage = 1
    movies.removeAll()
    movieName = searchBar.text ?? ""
    requestData(movieName: movieName, page: currentPage) {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    print("Cancel")
    currentPage = 1
    movieName = ""
    movies.removeAll()
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
}
