//
//  PhotoListViewController.swift
//  EurekaChallenge
//
//  Created by lolivera on 05/10/2022.
//

import UIKit

protocol PhotoListViewControllerDelegate {
  func photoListVCDidSelectItem(photoid: String)
}

class PhotoListViewController: UIViewController {
  
  
    // MARK: Structs
  
  struct ViewData {
    let photo: [String]
  }
  
  var delegate: PhotoListViewControllerDelegate?
  var viewData: ViewData? {
    didSet {
      DispatchQueue.main.async {
        // here un tableView whit photos i think
      }
    }
  }
}
