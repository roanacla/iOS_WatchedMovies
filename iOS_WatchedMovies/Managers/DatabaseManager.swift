//
//  ConfigurationManager.swift
//  iOS_WatchedMovies
//
//  Created by Roger Andres Navarro Claros on 6/22/21.
//

import Foundation
import CoreData

enum ListName: String {
  case watchedList = "WatchedList"
  case toWatchList = "ToWatchList"
}

class DatabaseManager {
  static func createDefaultListIfNeeded(using context: NSManagedObjectContext) {
    guard !UserDefaults.standard.bool(forKey: UserDefaultsKeys.firstLaunch.rawValue) else { return }
    createList(name: ListName.watchedList, in: context)
    createList(name: ListName.toWatchList, in: context)
    UserDefaults.standard.set(true, forKey: UserDefaultsKeys.firstLaunch.rawValue)
  }
  
  static func getWatchedList(using context: NSManagedObjectContext) -> CDList {
    return getListWith(name: ListName.watchedList.rawValue, using: context)
  }
  
  static func getToWatchList(using context: NSManagedObjectContext) -> CDList {
    return getListWith(name: ListName.toWatchList.rawValue, using: context)
  }
  
  private static func getListWith(name: String, using context: NSManagedObjectContext) -> CDList {
    let fetchRequest: NSFetchRequest<CDList> = CDList.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "name == %@", name)
    //3
    do {
      let list = try context.fetch(fetchRequest).first!
      return list
    } catch let error as NSError {
      fatalError("Could not fetch \(name). \(error), \(error.userInfo)")
    }
  }
  
  private static func createList(name: ListName, in context: NSManagedObjectContext) {
    let newList = CDList(context: context)
    newList.name = name.rawValue
    
    do {
      try context.save()
    } catch let error as NSError {
      fatalError("Error creating the default list \(name): \( error.description)" )
    }
  }
}
