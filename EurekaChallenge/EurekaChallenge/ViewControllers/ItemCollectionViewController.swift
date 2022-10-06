//
//  ItemCollectionViewController.swift
//  EurekaChallenge
//
//  Created by lolivera on 06/10/2022.
//

import UIKit

class ItemCollectionViewController: UIViewController {
  
  // MARK: Structs
  
  struct ViewData {
    let title: String
    let image: UIImageView?
    let latitude: String
    let longitude: String
  }
    
  // MARK: Attributes
  
  var viewData: ViewData? {
    didSet {
      guard let viewData = viewData else { return }
    }
  }
  
  // MARK: Outlets
  
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var longtitud: UILabel!
  @IBOutlet weak var latitud: UILabel!
  
    // MARK: Overrides
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    self.setUpComponentStyles()
  }
  
    // MARK: Methods
  
  func setUpComponentStyles() {
    self.contentView.layer.borderColor = UIColor.blue.cgColor
    self.contentView.layer.borderWidth = 0.5
    self.titleLabel.font = .boldSystemFont(ofSize: 20)
    self.titleLabel.numberOfLines = 4
    self.longtitud.font = .systemFont(ofSize: 16)
    self.longtitud.textColor = UIColor.init(red: 0, green: 150/255, blue: 0, alpha: 1)
    self.imageView.layer.cornerRadius = 15
  }
  
  func setUpComponentData(viewData: ViewData) {
    self.titleLabel.text = viewData.title
    self.imageView = viewData.image
    self.latitud.text = viewData.latitude
    self.longtitud.text = viewData.longitude
    }
}
