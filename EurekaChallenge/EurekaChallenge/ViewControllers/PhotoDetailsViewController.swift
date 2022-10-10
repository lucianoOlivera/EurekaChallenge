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
    let photo: Photo
  }
    // MARK: Attribute
  var passedContentOffset = IndexPath()
  var delegate: PhotoDetailsViewControllerDelegate?
  var viewData: ViewData? {
    didSet{
      DispatchQueue.main.async {
        self.collectionView?.reloadData()
      }
    }
  }
  
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet{
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
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.register(PhotoPreviewFullViewCell.self,forCellWithReuseIdentifier: "Cell")
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


extension  PhotoDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoPreviewFullViewCell
    cell.photoView.image = self.viewData?.photo.content
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1 
  }
  
}

extension PhotoDetailsViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width , height:  self.view.frame.width)
  }
}
