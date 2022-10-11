//
//  GenericCoordinatorBase.swift
//  EurekaChallenge
//
//  Created by lolivera on 05/10/2022.
//

import Foundation
import UIKit

public class GenericCoordinatorBase: CoordinatorBase {
  func start() {
  }
  
    // MARK: Attributes
  var navVC: UINavigationController
  var rootViewController: UIViewController
  
    // MARK: Methods  
  
  init(rootViewController: UIViewController, navVC: UINavigationController) {
    self.navVC = navVC
    self.rootViewController = rootViewController
    super.init()
  }
  
  func pushCoordinator(coordinator: inout GenericCoordinatorBase) {
    super.pushCoordinatorFrom(coordinator: &coordinator, rootVC:
                            self.rootViewController)
  }
  
  func popCoordinator(coordinator: GenericCoordinatorBase) {
    super.popCoordinatorFrom(coordinator: coordinator)
  }
}
