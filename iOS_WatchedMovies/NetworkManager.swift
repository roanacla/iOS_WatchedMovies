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
  case invalidURL = "Invalid URL"
}

class NetworkManager {
  
  static let shared = NetworkManager()
  private var baseURL = "https://www.omdbapi.com/?apikey=40ecf6b5&s="
  private let session = URLSession.shared
  let cache = NSCache<NSString, NSData>()
  
  private init() {}
  
  func getMovieWithName(name: String, page: Int = 1, completion: @escaping (Result<Search,RequestError>) -> ()) {
    let name = name.replacingOccurrences(of: " ", with: "+")
    let pageURL = "&page=\(page)"
    let completeURL = baseURL + name + pageURL
    guard let endPoint = URL(string: completeURL) else {
      completion(.failure(.invalidURL))
      return
    }
    
    let request = session.dataTask(with: endPoint) { (data, response, error) in
      guard let data = data else { completion(.failure(.noData)); return }
      
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        let searchResult = try decoder.decode(Search.self, from: data)
        completion(.success(searchResult))
      } catch {
        print("🔴")
        print(error.localizedDescription)
      }
    }
    
    request.resume()
  }
  
  func getImage(endpoint: String, completion: @escaping (Result<Data, RequestError>) -> Void) {
    if let data = cache.object(forKey: NSString(string: endpoint)) {
      completion(.success(Data(data)))
      return
    }
    
    guard let url = URL(string: endpoint) else {
      completion(.failure(.invalidURL))
      return
    }
    
    let request = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
      guard let self = self else { return }
      
      if let _ = error {
        completion(.failure(.error))
        return
      }
      
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      self.cache.setObject(NSData(data: data), forKey: NSString(string: endpoint))
      completion(.success(data))
    }
    request.resume()
  }

}
