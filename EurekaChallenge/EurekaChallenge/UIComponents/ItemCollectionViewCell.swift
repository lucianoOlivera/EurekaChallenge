//
//  CVCelll.swift
//  EurekaChallenge
//
//  Created by lolivera on 06/10/2022.
//

import UIKit
import Foundation

class ItemCollectionViewCell: UICollectionViewCell {
  
  
    // MARK: Structs
  
  struct ViewData {
    var title: String
    var imageVD: UIImageView?
    var latitude: String?
    var longitude: String?
  }
  
    // MARK: Attributes
  
  var viewData: ViewData? {
    didSet {
      guard let viewData = viewData else { return }
      self.setUpComponentData(viewData: viewData)
    }
  }
    // MARK: Outlets
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var longitudImage: UILabel!
  @IBOutlet weak var latitudImage: UILabel!
  
  
    // MARK: Overrides
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    self.setUpComponentStyles()
  }
  
    // MARK: Methods
  
  func setUpComponentStyles() {
    self.contentView.layer.borderColor = UIColor.blue.cgColor
    self.contentView.layer.borderWidth = 0.5
    self.title.font = .boldSystemFont(ofSize: 20)
    self.title.numberOfLines = 4
    self.longitudImage.font = .systemFont(ofSize: 16)
    self.longitudImage.textColor = UIColor.init(red: 0, green: 150/255, blue: 0, alpha: 1)
    self.image.layer.cornerRadius = 15
  }
  
  func setUpComponentData(viewData: ViewData) {
    self.title.text = viewData.title
    self.image = viewData.imageVD
    self.latitudImage.text = viewData.latitude
    self.latitudImage.text = viewData.longitude
  }
}
