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
    var imageVD: UIImage?
  }
  
    // MARK: Attributes
  
  var viewData: ViewData? {
    didSet {
      guard let viewData = viewData else { return }
      self.setUpComponentData(viewData: viewData)
    }
  }
    // MARK: Outlets
  @IBOutlet weak var image: UIImageView!
  
  
    // MARK: Overrides
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    self.image.contentMode = .scaleAspectFill
  }
  
    // MARK: Methods
  
  func setUpComponentStyles() {
    self.image.contentMode = .scaleAspectFill
  }
  
  func setUpComponentData(viewData: ViewData) {
    self.image = UIImageView(image: self.viewData?.imageVD)
  }

}
