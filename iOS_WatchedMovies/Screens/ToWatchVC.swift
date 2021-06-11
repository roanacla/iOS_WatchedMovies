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
  lazy var fetchedResultsController: NSFetchedResultsController<Entity> = {
    let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
    let sortByYear = NSSortDescriptor(key: #keyPath(Entity.year), ascending: false)
    fetchRequest.sortDescriptors = [sortByYear]
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
    fetchDataFromCoreData()
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
      if let entity = try? coreDataStack.managedContext.existingObject(with: entity) as? Entity {
        guard let name = entity.name,
              let imdbID = entity.imdbID,
              let posterLink = entity.posterURLString else { return nil }
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
