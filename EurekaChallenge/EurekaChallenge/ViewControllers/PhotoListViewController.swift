  //
  //  PhotoListViewController.swift
  //  EurekaChallenge
  //
  //  Created by lolivera on 05/10/2022.
  //

import UIKit
import Foundation
import CoreData

protocol PhotoListViewControllerDelegate {
  func photoListVCDidSelectItem(photo: Photo)
}

class PhotoListViewController: UIViewController, ViewDataCompliant{
  
  public var context = CoreDataManager.shared.persistentContainer.viewContext
  
  private let reuseIdentifier = "DateCell"
  
  private var photoAdapter = Adapter()
  
    // MARK: Structs
  
  struct ViewData {
    var photos: [Photo]
  }
  
  var photos1: [Photo] = []
  
  @IBOutlet weak var takePhoto: UIButton!
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  
  lazy var layout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
      // Handle automatic layout on iPad to allow portrait and landscape modes
    if UIDevice.current.userInterfaceIdiom == .pad {
      layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
    return layout
  }()
  
    // MARK: Life Cycle
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Eureka Challenge"
    self.navigationController?.navigationBar.barTintColor = UIColor.yellow
    self.definesPresentationContext = true
    self.navigationController?.navigationBar.barTintColor = UIColor.yellow
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    self.collectionView.register(PhotoItemCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    self.collectionView.backgroundColor = UIColor.white
    self.collectionView.collectionViewLayout = self.layout
    self.takePhoto.translatesAutoresizingMaskIntoConstraints = false
    self.takePhoto.setTitle("Take Photo", for: .normal)
    self.takePhoto.setTitleColor(.blue, for: .normal)
    self.takePhoto.backgroundColor = UIColor.lightGray
    self.takePhoto.layer.cornerRadius = 5
    self.takePhoto.addTarget(self, action: #selector(takePicture), for: .touchDown)
    self.photos1 = photoAdapter.getRequestPhoto()
  }
  var delegate: PhotoListViewControllerDelegate?
  var viewData: ViewData? {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  @objc func takePicture() {
    let picker = UIImagePickerController()
    picker.sourceType = .camera 
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
  }
  
}


extension PhotoListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PhotoItemCollectionViewCell else {
      assertionFailure("Could not dequeue cell for row \(indexPath.row) in collection view")
      return UICollectionViewCell()
    }
    
    let item = self.photos1[indexPath.row] 
    
    
      //    let cellViewData = PhotoItemCollectionViewCell.ViewData(imageVD:item.content)
    
    cell.img.image = item.content
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return self.photos1.count 
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
    return self.photos1.count 
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
  {
    let width = collectionView.frame.width
    if DeviceInfo.Orientation.isPortrait {
      return CGSize(width: width/4 - 1, height: width/4 - 1)
    } else {
      return CGSize(width: width/6 - 1, height: width/6 - 1)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
//    guard let photo = self.viewData?.photos[indexPath.row] else {
//      assertionFailure("No Item for row \(indexPath.row) in collection view")
//      return
//    }
    self.delegate?.photoListVCDidSelectItem(photo: photos1[indexPath.row])
  }
}


extension PhotoListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
      return 
    }
    picker.dismiss(animated: true)
    
    let photo = Photo(context: self.context )
    photo.content = image
    
    try? self.context.save()
    self.viewDidLoad()
    self.collectionView.reloadData()
  }
}

struct DeviceInfo {
  struct Orientation {
      // indicate current device is in the LandScape orientation
    static var isLandscape: Bool {
      get {
        return UIDevice.current.orientation.isLandscape
      }
    }
      // indicate current device is in the Portrait orientation
    static var isPortrait: Bool {
      get {
        return UIDevice.current.orientation.isPortrait
      }
    }
  }
}
