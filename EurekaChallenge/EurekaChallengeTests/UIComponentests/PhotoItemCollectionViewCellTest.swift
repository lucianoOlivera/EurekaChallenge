//
//  PhotoItemCollectionViewCellTest.swift
//  EurekaChallengeTests
//
//  Created by lolivera on 10/10/2022.
//

import XCTest
@testable import class EurekaChallenge.PhotoItemCollectionViewCell

class PhotoItemCollectionViewCellTests: XCTestCase {
  var appCoordinatorBase:PhotoItemCollectionViewCell!
  
  override func setUp() {
    super.setUp()
    let bundle = Bundle(for: PhotoItemCollectionViewCell.self)
    guard let appCoordinatorBase = bundle.loadNibNamed("CustomView", owner: nil)?.first as? UIView else {
      return XCTFail("CustomView nib did not contain a UIView")
    }
  }

  override func tearDown() {
    appCoordinatorBase = nil
    super.tearDown()
  }
}
