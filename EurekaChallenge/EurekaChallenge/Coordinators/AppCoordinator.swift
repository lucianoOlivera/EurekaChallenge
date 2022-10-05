//
//  AppCoordinator.swift
//  EurekaChallenge
//
//  Created by lolivera on 05/10/2022.
//

import Foundation



import Foundation
import UIKit

protocol MasterDetailRooter {
  func displayMasterNavigation()
}

public class AppCoordinator: MainCoordinatorBase, MainCoordinator, UISplitViewControllerDelegate {
  func start() {
  }
  
    // MARK: Attributes
  
  let window: UIWindow
  let splitViewController: UISplitViewController
    
  init(window:UIWindow, SplitVC: UISplitViewController){
    self.window = window
    self.splitViewController = SplitVC
    
  }
  
  public func start() {
      //    self.setUpSplitViewController(masterVC: <#UINavigationController#>, detailVC: <#UINavigationController#>)
    self.showWindow(window: self.window, with: self.splitViewController)
    self.startMainCoordinators()
  }
  
  func setUpSplitViewController(masterVC: UINavigationController, detailVC: UINavigationController){
    self.splitViewController.preferredPrimaryColumnWidthFraction = 1
    self.splitViewController.preferredDisplayMode = .oneBesideSecondary
    self.splitViewController.viewControllers = [masterVC, detailVC]
    self.splitViewController.delegate = self
  }
  
  func showWindow(window:UIWindow, with rootViewControler: UIViewController){
    window.rootViewController = rootViewControler
    window.makeKeyAndVisible()
  }
  
  func startMainCoordinators() {
    var masterCoordinator: GenericCoordinatorBase
  }

}

extension AppCoordinator: MasterDetailRooter {
  func displayMasterNavigation() {
    (self.splitViewController.viewControllers.first as?
     UINavigationController)?.popToRootViewController(animated: true)
  }
}
