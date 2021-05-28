//
//  CustomTableViewCell.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 5/27/21.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
  
  static let reuseID = "MovieCell"
  var customImageView: UIImageView!
  var movieLabel: UILabel!
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.configureImage()
    self.configureLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("No storyBoard expected in this view")
  }
  
  func setCell(movie: Movie) {
    movieLabel.text = movie.title
    getMovieImage(posterLink: movie.poster)
  }
  
  private func configureImage() {
    self.customImageView = UIImageView()
    self.addSubview(customImageView)
    customImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      customImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      customImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      customImageView.widthAnchor.constraint(equalToConstant: 40),
      customImageView.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
  
  private func configureLabel() {
    self.movieLabel = UILabel(frame: .zero)
    self.movieLabel.textAlignment = .left
    self.movieLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    self.addSubview(movieLabel)
    self.movieLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      movieLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 20),
      movieLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
      movieLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
  
  func getMovieImage(posterLink: String) {
    NetworkManager.shared.getImage(endpoint: posterLink) { (result) in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          self.customImageView.image = UIImage(data: data)
        }
      case .failure(let error):
        print(error.rawValue)
      }
    }
  }
}
