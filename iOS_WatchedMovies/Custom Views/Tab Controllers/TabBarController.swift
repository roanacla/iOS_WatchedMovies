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
    
    viewControllers = [createSearchNC(), createCommCollVC(), createDiffableNC(), createCollectionNC(), createFavoritiesNC()]
  }
  
  func createSearchNC() -> UINavigationController {
    let SearchVC        = SearchRouter.setupModule()
    SearchVC.title      = "Common"
    SearchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    
    return UINavigationController(rootViewController: SearchVC)
  }
  
  func createCommCollVC() -> UINavigationController {
    let commCollVC = CommCollVC()
    commCollVC.title = "Common Collection"
    commCollVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
    
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
