//
//  File.swift
//  EurekaChallenge
//
//  Created by lolivera on 06/10/2022.
//

import Foundation
/**
 An object that adopts the MasterDetailRooter protocol is responsible for providing
 the navigation between master and details Navigation Controllers.
 
 Since the Master and Details Coordinators handles the master and details navigations respectively, they are never removed, thus this navigation can not be handled by removing coordinators.
 */
protocol ViewDataCompliant {
  associatedtype ViewData
  /**
   The viewData represents an object which is intended to give a data entry point
   for a UI class, such as View Controllers, Collection View Cells,
   Table View Cells, etc that should display data on the user interface.
   The intention of this approach is to avoid having a lot of variables
   spread out on UI classes which can update the user interfaz,
   this makes easier to find out where the data is setted, more consistency
   and also makes the code cleaner.
   */
  var viewData: ViewData? { get set }
}
