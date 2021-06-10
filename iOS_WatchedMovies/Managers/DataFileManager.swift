//
//  JSONManager.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 6/9/21.
//

import Foundation

enum DataFileManagerError: String, Error {
  case savingInDisk = "Error saving in disk"
  case readFromDisk = "Error reading from disk"
}

class DataFileManager {
  
  static let shared = DataFileManager()
  
  private init() {}
  
  private let pathToWatchList: URL = URL(fileURLWithPath: "ToWatchList.json",
                              relativeTo: FileManager.documentDirectoryURL)
  
  func storeToWatchList(movieDetails: [MovieDetail]) throws {
    do {
      let jsonEncoder = JSONEncoder()
      jsonEncoder.outputFormatting = .prettyPrinted
      let jsonData = try jsonEncoder.encode(movieDetails)
      try jsonData.write(to: pathToWatchList)
    } catch {
      throw error
    }
  }
  
  func getToWatchList() -> Result<[MovieDetail], DataFileManagerError> {
    do {
      
      let data = try Data(contentsOf: pathToWatchList)
      let jsonDecoder = JSONDecoder()
      let movieDetails = try jsonDecoder.decode([MovieDetail].self, from: data)
      return .success(movieDetails)
    } catch {
      print("🔴" + error.localizedDescription)
      return .failure(.readFromDisk)
    }
  }
  
  func storeMoviePoster(movieDetail: MovieDetail, posterData: Data) -> Bool {
    let posterURL = URL(fileURLWithPath: movieDetail.imdbID , relativeTo: FileManager.documentDirectoryURL)
    do {
      try posterData.write(to: posterURL)
      return true
    } catch {
      print("🔴" + error.localizedDescription)
      return false
    }
  }
  
  func getMoviePoster(imdbID: String) -> Result<Data,DataFileManagerError> {
    do {
      let posterURL = URL(fileURLWithPath: imdbID, relativeTo: FileManager.documentDirectoryURL)
      let data = try Data(contentsOf: posterURL)
      return .success(data)
    } catch {
      return .failure(.readFromDisk)
    }
  }
}
