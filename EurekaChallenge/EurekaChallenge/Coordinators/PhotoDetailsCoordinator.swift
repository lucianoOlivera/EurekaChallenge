//
//  PhotoDetailsCoordinator.swift
//  EurekaChallenge
//
//  Created by lolivera on 05/10/2022.
//

import UIKit

public class PhotoDetailsCoordinator: GenericCoordinatorBase, GenericCoordinator {
  
    // MARK: Attributes
    var delegate: MasterDetailRooterControllers?
    
    // MARK: Methods
  
  init(rootVC: UIViewController, navVC: UINavigationController) {
    super.init(rootViewController: rootVC, navVC: navVC)
  }
  
  public override func start() {}
  
  public func displayItemDetails(photo: Photo){
    let photoDetailsVC = self.rootViewController as? PhotoDetailsViewController
    photoDetailsVC?.delegate = self
    photoDetailsVC?.viewData = PhotoDetailsViewController.ViewData(photo: photo)
  }
  
  func finish() {
    popCoordinator(coordinator: self)
  }
}

extension PhotoDetailsCoordinator: PhotoDetailsViewControllerDelegate {
  func photoDetailsVCDidSelectBackButton() {
    self.delegate?.displayMasterNavigation()
  }
}
