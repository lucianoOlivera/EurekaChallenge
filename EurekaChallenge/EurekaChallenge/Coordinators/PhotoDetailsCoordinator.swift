//
//  PhotoDetailsCoordinator.swift
//  EurekaChallenge
//
//  Created by lolivera on 05/10/2022.
//

import UIKit

public class PhotoDetailsCoordinator: GenericCoordinatorBase, GenericCoordinator {
  
    // MARK: Attributes
    var photoId: String?
    var delegate: MasterDetailRooter?
    
    // MARK: Methods
  
  init(rootVC: UIViewController, navVC: UINavigationController) {
    super.init(rootViewController: rootVC, navVC: navVC)
  }
  
  public override func start() {}
  
  public func displayItemDetails(photoId: String){
    let photoDetailsVC = self.rootViewController as? PhotoDetailsViewController
    // search photos id in real 
//    guard let self = self, let item = item as? ItemImmutableModel else { return }
//    photoDetailsVC?.delegate = self
//    photoDetailsVC?.viewData = PhotoDetailsViewController.ViewData(photo: photo)
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
