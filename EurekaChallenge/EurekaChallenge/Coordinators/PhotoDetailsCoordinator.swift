//
//  PhotoDetailsCoordinator.swift
//  EurekaChallenge
//
//  Created by lolivera on 05/10/2022.
//

import UIKit

protocol PhotoDetailsViewControllerDelegate {
  func photoDetailsVCDidSelectBackButton()
  func photoDetailsVCDidSelectBackButtonDetailsVCDidSelectBuyButton(photoURL: String)
}

public class PhotoDetailsCoordinator: GenericCoordinatorBase, GenericCoordinator {
  
    // MARK: Attributes
    var photoId: String?
    var delegate: MasterDetailRooter?
  
    // MARK: Methods
  
  init(rootVC: UIViewController, navVC: UINavigationController) {
    super.init(rootViewController: rootVC, navVC: navVC)
  }
  
  public override func start() {}
  
  public func displayItemDetails(photoId: String){}
  
  func finish() {
    popCoordinator(coordinator: self)
  }
}

