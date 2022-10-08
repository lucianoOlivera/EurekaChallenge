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

class PhotoListViewController: UIViewController, ViewDataCompliant {
  
  func photoListVCDidSelectItem(photoid: String) {}
  
  private let reuseIdentifier = "DateCell"
  
  // MARK: Structs
  
  struct ViewData {
    var photos: [ItemImmutableModel] 
  }
  
  @IBOutlet weak var collectionView: UICollectionView!
  
    // MARK: Life Cycle
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Eureka Challenge"
    self.navigationController?.navigationBar.barTintColor = UIColor.yellow
    self.definesPresentationContext = true
    self.navigationController?.navigationBar.barTintColor = UIColor.yellow
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    self.collectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DateCell")
  }
  var delegate: PhotoListViewControllerDelegate?
  var viewData: ViewData? {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
}


extension PhotoListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PhotoListViewControllerDelegate {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ItemCollectionViewCell else {
      assertionFailure("Could not dequeue cell for row \(indexPath.row) in collection view")
      return UICollectionViewCell()
    }
    
//    guard let item = photo[indexPath.row] else {
//      assertionFailure("No Item for row \(indexPath.row) in collection view")
//      return UICollectionViewCell()
//    }
    
    let cellViewData = ItemCollectionViewCell.ViewData(title: "test",latitude: "asd", longitude: "asdas")

    cell.viewData = cellViewData    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
  {
    return CGSize(width: 100, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
    
//    guard let photos = self.viewData?.photos[indexPath.row], let photos = photos.id else {
//      assertionFailure("No Item for row \(indexPath.row) in collection view")
//      return
//    }
    self.delegate?.photoListVCDidSelectItem(photoid:"1")
  }
}
