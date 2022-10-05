//
//  CoordinatorBase.swift
//  EurekaChallenge
//
//  Created by lolivera on 05/10/2022.
//

import Foundation
import UIKit

public class CoordinatorBase {
  
    // MARK: Attributes
  
  weak var parentCordinator: CoordinatorBase?
  var childCoordinators: [GenericCoordinatorBase]
  
    // MARK: Methods
  
  init() {
    self.childCoordinators = [GenericCoordinatorBase]()
  }
  
  func pushCoordinator(coordinator: inout GenericCoordinatorBase, 
                       rootVC: UIViewController,
                       animated: Bool = true) {
    self.childCoordinators.append(coordinator)
    coordinator.parentCordinator = self
    coordinator.navVC.pushViewController(rootVC, animated: animated)
  }
  
    /// Removes a coordinator with all it's View Controllers.
  func popCoordinator(coordinator: GenericCoordinatorBase, 
                      animated: Bool = true){
    guard let coordinatorIdex = self.childCoordinators.firstIndex(where: {$0 === coordinator}) else {return}
    self.popCoordinatorRootVC(coordinate: coordinator, animated: animated)
    self.childCoordinators.remove(at: coordinatorIdex)
  }
    /// Removes the View Controllers within a coordinator.
  func popCoordinatorRootVC(coordinate: GenericCoordinatorBase, 
                            animated: Bool = true){
    coordinate.navVC.popToViewController(coordinate.rootViewController, animated: animated)
    coordinate.navVC.popViewController(animated: animated)
  }
}

