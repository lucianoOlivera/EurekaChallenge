//
//  PhotoListCoordinator.swift
//  EurekaChallenge
//
//  Created by lolivera on 05/10/2022.
//

import UIKit

public class PhotoListCoordinator: GenericCoordinatorBase, GenericCoordinator, PhotoListViewControllerDelegate {
  
    // MARK: Attributes
    var delegate: MasterDetailRooter?
  
    // MARK: Methods
    init(rootVC: UIViewController, navVC: UINavigationController) {
    super.init(rootViewController: rootVC, navVC: navVC)
  }
  
  public override func start() {
    let photoListViewController = self.rootViewController as? PhotoListViewController
    photoListViewController?.delegate = self
  }

  func finish() {
    self.popCoordinator(coordinator: self)
  }
  
  func photoListVCDidSelectItem(photoid photoId: String) {
    self.delegate?.displayDetailNavigation(photoId:photoId )
  }
}

