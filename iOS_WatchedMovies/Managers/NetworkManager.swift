//
//  NetworkManager.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 5/25/21.
//

import Foundation
import UIKit

enum RequestError: String, Error {
  case noData = "No data received"
  case error = "Error with request"
  case errorResponse = "No response"
  case invalidURL = "Invalid URL"
}

class NetworkManager {
  
  static let shared = NetworkManager()
  private var baseURL = "https://www.omdbapi.com/?apikey=40ecf6b5&s="
  private var pageURL = "&page="
  private var byIDURL = "https://www.omdbapi.com/?apikey=40ecf6b5&i="
  private let session = URLSession.shared
  let cache = NSCache<NSString, NSData>()
  
  private init() {}
  
  func getMovieWithName(name: String, page: Int = 1, completion: @escaping (Result<Search,RequestError>) -> ()) {
    let name = name.replacingOccurrences(of: " ", with: "+")
    let urlString = baseURL + name + pageURL + "\(page)"
    guard let url = URL(string: urlString) else {
      completion(.failure(.invalidURL))
      return
    }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let _ = error {
        completion(.failure(.error))
        return
      }
      
      guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
        completion(.failure(.error))
        return
      }
      
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let search = try decoder.decode(Search.self, from: data)
        completion(.success(search))
      } catch {
        completion(.failure(.error))
      }
    }.resume()
  }
  
  func getMovieByID(id: String, completion: @escaping (Result<MovieDetail, RequestError>) -> Void) {
    let stringURL = byIDURL + id
    guard let url = URL(string: stringURL) else {
      completion(.failure(.invalidURL))
      return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let _ = error {
        completion(.failure(.error))
      }
      
      guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
        completion(.failure(.errorResponse))
        return
      }
      
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let movieDetail = try decoder.decode(MovieDetail.self, from: data)
        completion(.success(movieDetail))
      } catch {
        print("🔴 Error decoding movie")
      }
    }.resume()
  }
  
  func getImage(for movie: Movie, completion: @escaping (Result<Data, RequestError>) -> Void) {
    if let data = cache.object(forKey: NSString(string: movie.imdbID)) {
      completion(.success(Data(data)))
      return
    }
    
    guard let url = URL(string: movie.poster) else {
      completion(.failure(.invalidURL))
      return
    }
    
    let request = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
      guard let self = self else { return }
      
      if let _ = error {
        completion(.failure(.error))
        return
      }
      
      guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
        completion(.failure(.error))
        return
      }
      
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      self.cache.setObject(NSData(data: data), forKey: NSString(string: movie.imdbID))
      completion(.success(data))
    }
    request.resume()
  }

}
