//
//  CoreDataManager.swift
//  EurekaChallenge
//
//  Created by lolivera on 09/10/2022.
//

import Foundation
import CoreData

class CoreDataManager {
  
  let persistentContainer: NSPersistentContainer
  static let shared: CoreDataManager = CoreDataManager()
  
  private init() {
    
    ValueTransformer.setValueTransformer(UIImageTransformer(), forName: NSValueTransformerName("UIImageTransformer"))
    
    self.persistentContainer = NSPersistentContainer(name: "EurekaChallenge")
    persistentContainer.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Unable to initialize Core Data \(error)")
      }
    }
    
  }
}
