//
//  NetworkManager.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 5/25/21.
//

import Foundation


enum RequestError: String, Error {
  case noData = "No data received"
  case error = "Error with request"
  case invalidURL = "Invalid URL"
}

class NetworkManager {
  
  static let shared = NetworkManager()
  private var baseURL = "https://www.omdbapi.com/?apikey=40ecf6b5&t="
  private let session = URLSession.shared
  
  private init() {}
  
  func getMovieWithName(name: String, completion: @escaping (Result<Movie,RequestError>) -> ()) {
    let name = name.replacingOccurrences(of: " ", with: "+")
    guard let endPoint = URL(string: baseURL + name) else {
      completion(.failure(.invalidURL))
      return
    }
    
    let request = session.dataTask(with: endPoint) { (data, response, error) in
      guard let data = data else { completion(.failure(.noData)); return }
      
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        
        let movie = try decoder.decode(Movie.self, from: data)
        completion(.success(movie))
      } catch {
        print("🔴")
        print(error.localizedDescription)
      }
    }
    
    request.resume()
  }
  
  func getImage(endpoint: String, completion: @escaping (Result<Data, RequestError>) -> Void) {
    guard let url = URL(string: endpoint) else {
      completion(.failure(.invalidURL))
      return
    }
    let request = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let _ = error {
        completion(.failure(.error))
        return
      }
      
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      completion(.success(data))
    }
    request.resume()
  }

}
