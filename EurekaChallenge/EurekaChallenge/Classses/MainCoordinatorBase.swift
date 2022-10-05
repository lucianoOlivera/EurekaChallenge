//
//  MainCoordinatorBase.swift
//  EurekaChallenge
//
//  Created by lolivera on 05/10/2022.
//

import UIKit


public class MainCoordinatorBase: CoordinatorBase {
    // MARK: Attributes
  
  var masterNavVC: UINavigationController
  var detailNavVC: UINavigationController
  var masterRootVC: UIViewController
  var detailRootVC: UIViewController
  
    // MARK: Methods
  
  init(masterNavVC: UINavigationController,
       detailNavVC: UINavigationController,
       masterRootVC: UIViewController,
       detailRootVC: UIViewController) {
    self.masterNavVC = masterNavVC
    self.detailNavVC = detailNavVC
    self.masterRootVC = masterRootVC
    self.detailRootVC = detailRootVC
    super.init()
  }
  
  func pushMasterCoordinator(coordinator: inout GenericCoordinatorBase) {
    super.pushCoordinator(coordinator: &coordinator, rootVC: masterRootVC)
  }
  
  func pushDetailCoordinator(coordinator: inout GenericCoordinatorBase) {
    super.pushCoordinator(coordinator: &coordinator, rootVC: detailRootVC)
  }
  
  func popMasterCoordinator(coordinator: inout GenericCoordinatorBase) {
    super.popCoordinator(coordinator: coordinator)
  }
  
  func popDetailCoordinator(coordinator: inout GenericCoordinatorBase) {
    super.popCoordinator(coordinator: coordinator)
  }
}
