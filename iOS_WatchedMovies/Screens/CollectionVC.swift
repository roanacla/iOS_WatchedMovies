//
//  CollectionVC.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 5/31/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionVC: UIViewController {
  
  enum Section: CaseIterable {case main}
  
  //MARK: - Outlets
  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!

  //MARK: - Properties
  var currentPage = 1
  var movieName = "star wars"
  var totalResults: Int = 0
  var data: [Movie] = []
  var hasMoreResults: Bool {
    return data.count < totalResults ? true : false
  }
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configureDataSource()
    getMovieData(movieName: movieName, page: currentPage)
  }
  
  //MARK: - Functions
  
  func getMovieData(movieName: String, page: Int) {
    NetworkManager.shared.getMovieWithName(name: movieName, page: page) { (results) in
      switch results {
      case .success(let search):
        self.totalResults = Int(search.totalResults) ?? 0
        print(self.totalResults)
        self.data.append(contentsOf: search.movies ?? [])
        self.updateDataSource(movies: self.data)
      case .failure(let error):
        print(error.rawValue)
      }
    }
  }
  
  //MARK: - Views Configuration
  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CollectionViewLayout.createThreeColumnFlowLayout(in: view))
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseID)
    collectionView.backgroundColor = .systemBackground
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  //MARK - Deffiable data source
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseID, for: indexPath) as? CollectionViewCell
      cell?.set(movieName: movie.title, imdbID: movie.imdbID, posterLink: movie.poster)
      return cell
    })
  }
  
  func updateDataSource(movies: [Movie]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
    snapshot.appendSections([.main])
    snapshot.appendItems(movies)
    DispatchQueue.main.async {
      self.dataSource.apply(snapshot, animatingDifferences: true)
    }
  }
  
}

extension CollectionVC: UICollectionViewDelegate {
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
}
