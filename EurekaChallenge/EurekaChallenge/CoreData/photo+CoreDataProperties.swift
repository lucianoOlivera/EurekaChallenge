//
//  photo+CoreDataProperties.swift
//  EurekaChallenge
//
//  Created by lolivera on 09/10/2022.
//

import Foundation
import CoreData


extension Photo {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
    return NSFetchRequest<Photo>(entityName: "Picture")
  }
  
  @NSManaged public var photoData: NSData?
  @NSManaged public var photoDate: NSDate?
  
  
}
