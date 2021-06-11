//
//  CollectionViewCell.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 5/31/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  static let reuseID = "MovieCollectionCell"
  var imageView =  UIImageView(frame: .zero)
  var movieLabel = UILabel(frame: .zero)
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    movieLabel.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false
    configure()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  func set(movieName: String, imdbID: String, posterLink: String) {
    movieLabel.text = movieName
    getMovieImage(imdbID: imdbID, posterLink: posterLink)
  }
  
  
  private func configure() {
    addSubview(movieLabel)
    addSubview(imageView)
    let padding: CGFloat = 8
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
      
      movieLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
      movieLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      movieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      movieLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
  
  func getMovieImage(imdbID: String, posterLink: String) {
    imageView.image = nil
    NetworkManager.shared.getImage(imdbID: imdbID, posterURLString: posterLink) { (result) in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          self.imageView.image = UIImage(data: data)
        }
      case .failure(let error):
        print(error.rawValue)
      }
    }
  }
}
