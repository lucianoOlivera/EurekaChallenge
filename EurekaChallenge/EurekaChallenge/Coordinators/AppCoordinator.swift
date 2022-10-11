//
//  AppCoordinator.swift
//  EurekaChallenge
//
//  Created by lolivera on 05/10/2022.
//

import Foundation
import UIKit

protocol MasterDetailRooterControllers {
  func displayDetailNavigation(photo: Photo)
  func displayMasterNavigation()
}

public class AppCoordinator: MainCoordinatorBase, MainCoordinator, UISplitViewControllerDelegate {
  
    // MARK: Attributes
  
  let window: UIWindow
  let splitViewController: UISplitViewController
  var photoListCoordinator: PhotoListCoordinator? { return self.childCoordinators.first as? PhotoListCoordinator}
  var photoDetailsCoordinator: PhotoDetailsCoordinator? { return self.childCoordinators.last as? PhotoDetailsCoordinator }
  
  init(window:UIWindow, splitVC: UISplitViewController){
    self.window = window
    self.splitViewController = splitVC
    
    let masterNavVC = UINavigationController()
    let detailNavVC = UINavigationController()
    let masterRootVC = PhotoListViewController()
    let detailRootVC = PhotoDetailsViewController()
    
    super.init(masterNavVC: masterNavVC,
               detailNavVC: detailNavVC,
               masterRootVC: masterRootVC,
               detailRootVC: detailRootVC)
    
  }
  
  public func start() {
    self.setUpSplitViewController(masterVC: self.masterNavVC, detailVC: self.detailNavVC)
    self.showWindow(window: self.window, with: self.splitViewController)
    self.startMainCoordinator()
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
  
  func startMainCoordinator() {
    var masterCoordinator: GenericCoordinatorBase = PhotoListCoordinator(rootVC: masterRootVC, navVC: masterNavVC)
    self.pushMasterCoordinator(coordinator: &masterCoordinator)
    self.photoListCoordinator?.delegate = self
    self.photoListCoordinator?.start()
    
    var detailCoordinator: GenericCoordinatorBase = PhotoDetailsCoordinator(rootVC: detailRootVC, navVC: detailNavVC)
    self.pushDetailCoordinator(coordinator: &detailCoordinator)
    self.photoDetailsCoordinator?.delegate = self
    self.photoDetailsCoordinator?.start()
  }
  
}

extension AppCoordinator: MasterDetailRooterControllers {
  func displayMasterNavigation() {
    (self.splitViewController.viewControllers.first as?
     UINavigationController)?.popToRootViewController(animated: true)
  }
  
  func displayDetailNavigation(photo: Photo) {
    switch UIDevice.current.userInterfaceIdiom {
      case .phone:
        self.splitViewController.showDetailViewController(self.detailNavVC, sender: nil)
        (self.childCoordinators.last as? PhotoDetailsCoordinator)?.displayItemDetails(photo: photo)
      default:
        break
    }
  }
}
