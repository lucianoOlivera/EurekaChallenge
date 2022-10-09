//
//   factory.swift
//  EurekaChallenge
//
//  Created by lolivera on 09/10/2022.
//

import Foundation
import CoreData


class Adapter {
  
  var photos: [Photo] = []
  private var context = CoreDataManager.shared.persistentContainer.viewContext
    
  func getRequestPhoto()-> [Photo]{
    do {
      let request: NSFetchRequest<Photo> = NSFetchRequest(entityName: "Photo")
      let photos: [Photo] = try context.fetch(request)
      self.photos = photos
    } catch {
      print(error)
    }
    return self.photos
  }
}