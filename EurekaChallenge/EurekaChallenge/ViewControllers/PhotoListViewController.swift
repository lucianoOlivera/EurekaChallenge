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
  
  @IBOutlet weak var CollectionView: UICollectionView!
  
    // MARK: Life Cycle
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Eureka Challenge"
    self.navigationController?.navigationBar.barTintColor = UIColor.yellow
    self.definesPresentationContext = true
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
