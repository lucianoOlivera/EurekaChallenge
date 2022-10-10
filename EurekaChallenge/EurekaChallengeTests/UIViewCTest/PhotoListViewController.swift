//
//  PhotoListViewController.swift
//  EurekaChallengeTests
//
//  Created by lolivera on 10/10/2022.
//

import XCTest
@testable import class EurekaChallenge.PhotoListViewController

class PhotoListViewControllerTests: XCTest {

  var appCoordinatorBase: PhotoListViewController!
  var collectionView: UICollectionView! { return self.appCoordinatorBase.collectionView }
  var dataSource: UICollectionViewDataSource! { return self.appCoordinatorBase.collectionView!.dataSource }
  
  override func setUp() {
    super.setUp()
    self.appCoordinatorBase = PhotoListViewController()
    _ = appCoordinatorBase.view
  }
  
  
  override func tearDown() {
    self.appCoordinatorBase = nil
    super.tearDown()
  }
  
  func testLoadPhotoDetailsViewControllerWithoutData() {
    givenNoData()
    
    XCTAssertEqual(dataSource.numberOfSections?(in: collectionView!), 0)
  }
  
  // MARK: Given
  
  func givenNoData() {
    self.appCoordinatorBase.viewData = nil
  }
  
}
