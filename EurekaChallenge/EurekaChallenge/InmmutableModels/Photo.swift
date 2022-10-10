//
//  Photo.swift
//  EurekaChallenge
//
//  Created by lolivera on 09/10/2022.
//

import CoreData
import Foundation
import UIKit

@objc(Photo)
public class Photo: NSManagedObject {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
    return NSFetchRequest<Photo>(entityName: "Photo")
  }
  
  @NSManaged public var content: UIImage?
  @NSManaged public var latitude: String?
  @NSManaged public var longitude: String?
}

extension Photo : Identifiable {
  
}
