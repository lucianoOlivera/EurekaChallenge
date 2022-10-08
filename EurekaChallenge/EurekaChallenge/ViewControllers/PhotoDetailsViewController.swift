//
//  PhotoDetailsViewController.swift
//  EurekaChallenge
//
//  Created by lolivera on 05/10/2022.
//

import UIKit

protocol PhotoDetailsViewControllerDelegate {
  func photoDetailsVCDidSelectBackButton()
}

class PhotoDetailsViewController: UIViewController, ViewDataCompliant{
    // MARK: Structs 
  struct ViewData {
    let photo: ItemImmutableModel
  }
    // MARK: Attributes
  var delegate: PhotoDetailsViewControllerDelegate?
  var viewData: ViewData? {
    didSet{
      DispatchQueue.main.async {
      }
    }
  }
  
  lazy var layoutConfiguration: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    return layout
  }()
  
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet{
      self.collectionView.collectionViewLayout = self.layoutConfiguration
    }
  }
    // MARK: Events
  @objc func back(sender: UIBarButtonItem) {
    delegate?.photoDetailsVCDidSelectBackButton()
  }
  
    // MARK: Life Cycle
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "EurekaChallenge"
    self.navigationController?.navigationBar.barTintColor = .blue
    self.displayBackButton(userInterfaz: UIDevice.current.userInterfaceIdiom)
    
  }
  
    // MARK: Methods
  
  func displayBackButton(userInterfaz: UIUserInterfaceIdiom) {
      // Allows Details View Controller to go back to the Master View Controller
      // when the app user interface idiom is iPhone.
    if userInterfaz == .phone {
      self.navigationItem.hidesBackButton = true
      let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                       style: UIBarButtonItem.Style.plain,
                                       target: self,
                                       action: #selector(back(sender:)))
      self.navigationItem.leftBarButtonItem = backButton
    }
  }
}
