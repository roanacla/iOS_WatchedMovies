//
//  CollectionViewLayout.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 6/8/21.
//

import UIKit

class CollectionViewLayout {
  static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
      let width                       = view.bounds.width
      let padding: CGFloat            = 12
      let minimumItemSpacing: CGFloat = 10
      let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
      let itemWidth                   = availableWidth / 2
      
      let flowLayout                  = UICollectionViewFlowLayout()
      flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
      flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth*1.47 + 40)
      
      return flowLayout
  }
}
