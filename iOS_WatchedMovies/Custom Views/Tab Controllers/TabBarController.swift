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
      
      viewControllers                 = [createCommonNC(), createDiffableNC()]
    }
    
  func createCommonNC() -> UINavigationController {
      let commonVC        = CommonVC()
      commonVC.title      = "Common"
      commonVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
      
      return UINavigationController(rootViewController: commonVC)
  }
  
  
  func createDiffableNC() -> UINavigationController {
      let diffableVC         = DiffableVC()
      diffableVC.title       = "Diffable"
      diffableVC.tabBarItem  = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
      
      return UINavigationController(rootViewController: diffableVC)
  }

}
