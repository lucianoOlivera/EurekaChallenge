//
//  PhotoItemCollectionViewCell.swift
//  EurekaChallenge
//
//  Created by lolivera on 09/10/2022.
//

import UIKit


class PhotoItemCollectionViewCell: UICollectionViewCell {
  
  var img = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    img.contentMode = .scaleAspectFill
    img.clipsToBounds = true
    self.addSubview(img)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    img.frame = self.bounds
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
