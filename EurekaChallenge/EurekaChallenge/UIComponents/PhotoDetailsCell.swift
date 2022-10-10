//
//  PhotoPreviewFullViewCell.swift
//  EurekaChallenge
//
//  Created by lolivera on 10/10/2022.
//
import UIKit

class PhotoPreviewFullViewCell: UICollectionViewCell, UIScrollViewDelegate {
  
  var scrollPhoto: UIScrollView!
  var photoView: UIImageView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    scrollPhoto = UIScrollView()
    scrollPhoto.delegate = self
    scrollPhoto.alwaysBounceVertical = false
    scrollPhoto.alwaysBounceHorizontal = false
    scrollPhoto.showsVerticalScrollIndicator = true
    scrollPhoto.flashScrollIndicators()
    
    scrollPhoto.minimumZoomScale = 1.0
    scrollPhoto.maximumZoomScale = 4.0
    
    let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
    doubleTapGest.numberOfTapsRequired = 2
    scrollPhoto.addGestureRecognizer(doubleTapGest)
    
    self.addSubview(scrollPhoto)
    
    photoView = UIImageView()
    photoView.image = UIImage(named: "user3")
    scrollPhoto.addSubview(photoView!)
    photoView.contentMode = .scaleAspectFit
  }
  
  @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
    if scrollPhoto.zoomScale == 1 {
      scrollPhoto.zoom(to: zoomRectForScale(scale: scrollPhoto.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
    } else {
      scrollPhoto.setZoomScale(1, animated: true)
    }
  }
  
  func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
    var zoomRect = CGRect.zero
    zoomRect.size.height = photoView.frame.size.height / scale
    zoomRect.size.width  = photoView.frame.size.width  / scale
    let newCenter = photoView.convert(center, from: scrollPhoto)
    zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
    zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
    return zoomRect
  }
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.photoView
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    scrollPhoto.frame = self.bounds
    photoView.frame = self.bounds
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    scrollPhoto.setZoomScale(1, animated: true)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
