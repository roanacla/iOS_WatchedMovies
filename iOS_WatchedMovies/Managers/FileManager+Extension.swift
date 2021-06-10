//
//  FileManager+Extension.swift
//  iOS_WatchedMovies
//
//  Created by Roger Navarro on 6/9/21.
//

import Foundation

extension FileManager {
  static var documentDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}
