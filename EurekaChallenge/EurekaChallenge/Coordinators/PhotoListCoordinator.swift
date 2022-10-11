//
//  PhotoListCoordinator.swift
//  EurekaChallenge
//
//  Created by lolivera on 05/10/2022.
//

import UIKit

public class PhotoListCoordinator: GenericCoordinatorBase, GenericCoordinator, PhotoListViewControllerDelegate {

    // MARK: Attributes
    var delegate: MasterDetailRooterControllers?
  
    private var photoAdapter = Adapter()
  
    private var locationManager = LocationService()
  
    // MARK: Methods
    init(rootVC: UIViewController, navVC: UINavigationController) {
    super.init(rootViewController: rootVC, navVC: navVC)
  }
  
  public override func start() {
    let photoListViewController = self.rootViewController as? PhotoListViewController
    photoListViewController?.delegate = self
    photoListViewController?.viewData = PhotoListViewController.ViewData(photoAdapter: photoAdapter, locationManager: locationManager)
  }
  func finish() {
    self.popCoordinator(coordinator: self)
  }
  
  func photoListVCDidSelectItem(photo: Photo) {
    self.delegate?.displayDetailNavigation(photo:photo )
  }
}

