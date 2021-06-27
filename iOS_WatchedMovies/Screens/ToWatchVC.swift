//
//  DiffCollVC.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 6/8/21.
//

import UIKit
import CoreData

class ToWatchVC: UIViewController {
  
  enum Section: CaseIterable {case main}
  
  //MARK: - View Components
  var collectionView: UICollectionView!
  
  //MARK: - Properties
  var dataSource: UICollectionViewDiffableDataSource<String, NSManagedObjectID>!
  var coreDataStack: CoreDataStack {
    (UIApplication.shared.delegate as! AppDelegate).coreDataStack
  }
  lazy var fetchedResultsController: NSFetchedResultsController<CDMovie> = {
    let fetchRequest: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
    let sortByYear = NSSortDescriptor(key: #keyPath(CDMovie.year), ascending: false)
    fetchRequest.sortDescriptors = [sortByYear]
    fetchRequest.predicate = NSPredicate(format: "ANY lists.name == %@", ListName.toWatchList.rawValue)
    let fetchedResultsController = NSFetchedResultsController(
      fetchRequest: fetchRequest,
      managedObjectContext: coreDataStack.managedContext,
      sectionNameKeyPath: nil,
      cacheName: "toWatchList")

    fetchedResultsController.delegate = self
    return fetchedResultsController
  }()
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configureDataSource()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UIView.performWithoutAnimation {
      fetchDataFromCoreData()
    }
  }
  
  //MARK: - View Conf Functions
  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CollectionViewLayout.createThreeColumnFlowLayout(in: view))
    collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseID)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
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
  func fetchDataFromCoreData() {
    do {
      try fetchedResultsController.performFetch()
    } catch let error as NSError {
      print("Fetching error: \(error), \(error.userInfo)")
    }
  }
  
  //MARK - Deffiable data source
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [unowned self] (collectionView, indexPath, entity) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseID, for: indexPath) as? CollectionViewCell
      if let cdMovie = try? coreDataStack.managedContext.existingObject(with: entity) as? CDMovie {
        guard let name = cdMovie.name,
              let imdbID = cdMovie.imdbId,
              let posterLink = cdMovie.posterURLString else { return nil }
        cell?.set(movieName: name, imdbID: imdbID, posterLink: posterLink)
      }
      return cell
    })
  }
}

//MARK: - CoreData Extension

extension ToWatchVC: NSFetchedResultsControllerDelegate {
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
    let snapshot = snapshot as NSDiffableDataSourceSnapshot<String,NSManagedObjectID>
    DispatchQueue.main.async {
      self.dataSource.apply(snapshot, animatingDifferences: true)
    }
  }
}
