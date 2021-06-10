//
//  TabBarController.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 5/31/21.
//

import UIKit

class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    UITabBar.appearance().tintColor = .systemGreen
    
    viewControllers = [createSearchNC(), createToWatchNC()]
  }
  
  func createSearchNC() -> UINavigationController {
    let SearchVC        = SearchRouter.setupModule()
    SearchVC.title      = "Search"
    SearchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    
    return UINavigationController(rootViewController: SearchVC)
  }
  
  func createToWatchNC() -> UINavigationController {
    let commCollVC = ToWatchVC()
    commCollVC.title = "To Watch"
    commCollVC.tabBarItem = UITabBarItem.init(title: "To watch", image: UIImage(systemName: "list.number"), tag: 1)
    
    return UINavigationController(rootViewController: commCollVC)
  }
  
  
  func createDiffableNC() -> UINavigationController {
    let diffableVC         = DiffableVC()
    diffableVC.title       = "Diffable"
    diffableVC.tabBarItem  = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
    
    return UINavigationController(rootViewController: diffableVC)
  }
  
  func createCollectionNC() -> UINavigationController {
    let collectionVC = CollectionVC()
    collectionVC.title = "Collection"
    collectionVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 3)
    
    return UINavigationController(rootViewController: collectionVC)
  }
  
  func createFavoritiesNC() -> UINavigationController {
    let favoritesVC = FavoritesVC()
    favoritesVC.title = "Favorites"
    favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 4)
    
    return UINavigationController(rootViewController: favoritesVC)
  }
  
}
