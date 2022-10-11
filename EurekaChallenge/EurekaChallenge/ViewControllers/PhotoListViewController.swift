  //
  //  PhotoListViewController.swift
  //  EurekaChallenge
  //
  //  Created by lolivera on 05/10/2022.
  //

import UIKit
import Foundation
import CoreData
import CoreLocation

protocol PhotoListViewControllerDelegate {
  func photoListVCDidSelectItem(photo: Photo)
}

class PhotoListViewController: UIViewController, ViewDataCompliant{
  
  public var context = CoreDataManager.shared.persistentContainer.viewContext
  
  private let reuseIdentifier = "Cell"
  
  private var latitude: String?
  
  private var longitude: String?
  
  var photos: [Photo] = []
  
  // MARK: Structs
  struct ViewData {
    var photoAdapter: Adapter
    var locationManager: LocationService
  }
  
  @IBOutlet weak var takePhoto: UIButton!
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  
  lazy var layout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
    return layout
  }()
  
    // MARK: Life Cycle
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Eureka Challenge"
    self.definesPresentationContext = true
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    self.collectionView.register(PhotoItemCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    self.collectionView.backgroundColor = UIColor.white
    self.collectionView.collectionViewLayout = self.layout
    self.takePhoto.translatesAutoresizingMaskIntoConstraints = false
    self.takePhoto.setTitle("Take Photo", for: .normal)
    self.takePhoto.setTitleColor(.blue, for: .normal)
    self.takePhoto.backgroundColor = UIColor.lightGray
    self.takePhoto.layer.cornerRadius = 5
    self.takePhoto.addTarget(self, action: #selector(takePicture), for: .touchDown)
    self.photos = self.viewData?.photoAdapter.getRequestPhoto() ?? []
    self.viewData?.locationManager.delegate = self
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
    self.viewData?.locationManager.determineCurrentLocation()    
    if !UIImagePickerController.isSourceTypeAvailable(.camera) {
      let alertController = UIAlertController(title: nil, message: "Device has no camera.", preferredStyle: .alert)
      
      let okAction = UIAlertAction(title: "Alright", style: .default, handler: { (alert: UIAlertAction!) in
      })
      
      alertController.addAction(okAction)
      self.present(alertController, animated: true, completion: nil)
      
    } else {
      
      let picker = UIImagePickerController()
      
      picker.sourceType = .camera 
      picker.allowsEditing = true
      picker.delegate = self
      
      present(picker, animated: true)
    }
  }
  

}

extension PhotoListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoItemCollectionViewCell else {
      assertionFailure("Could not dequeue cell for row \(indexPath.row) in collection view")
      return UICollectionViewCell()
    }
    let item = self.photos[indexPath.row] 
    cell.img.image = item.content
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return self.photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
    return self.photos.count
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
    self.delegate?.photoListVCDidSelectItem(photo: self.photos[indexPath.row] )
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
    
    guard let longitude = self.longitude, self.longitude != "" else {return}
    guard let latitude = self.latitude, self.latitude != "" else {return}
    self.viewData?.photoAdapter.savePhoto(uiImage: image,longitude:  longitude ,latitude: latitude )
    collectionLoad()
  }
  
  func collectionLoad(){
    self.viewDidLoad()
    self.collectionView.reloadData()
  }
}

extension PhotoListViewController: LocationServiceDelegate {
  func didUpdateLocations(_ coordinates: CLLocationCoordinate2D) {
    self.latitude = String(coordinates.latitude)
    self.longitude = String(coordinates.longitude)
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
