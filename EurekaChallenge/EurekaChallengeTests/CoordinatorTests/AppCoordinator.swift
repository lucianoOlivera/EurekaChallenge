//
//  CorrdinatorTests.swift
//  EurekaChallengeTests
//
//  Created by lolivera on 06/10/2022.
//

import XCTest
@testable import class EurekaChallenge.AppCoordinator

class AppCoordinatorTests: XCTestCase, TestBaseSystem {
  var sut: AppCoordinator!
  var UIwindow = UIWindow()
  var uisplitVC = UISplitViewController()
  
  override func setUp() {
    self.sut = AppCoordinator(window: UIwindow, splitVC: uisplitVC)
    super.setUp()
  }
  
  override func tearDown() {
    self.sut = nil
    super.tearDown()
  }
  
  func testSetUpSplitViewController() {
    let masterVC = UINavigationController()
    let detailVC = UINavigationController()
    sut.setUpSplitViewController(masterVC: masterVC, detailVC: detailVC)
    
    XCTAssertEqual(sut.splitViewController.preferredPrimaryColumnWidthFraction, 1)
    XCTAssertEqual(sut.splitViewController.viewControllers.count, 2)
    XCTAssertTrue(sut.splitViewController.viewControllers.contains(masterVC))
    XCTAssertTrue(sut.splitViewController.viewControllers.contains(detailVC))
    XCTAssertTrue(sut.splitViewController.delegate === sut)
    }
  
  
  func testStartCoordinatorsAndViewControllersMain() {
    sut.startMainCoordinators()
    
    let mCoordinator = sut.childCoordinators.first
    let dCoordinator = sut.childCoordinators.last
    
    XCTAssertEqual(sut.childCoordinators.count, 2)
    XCTAssertEqual(mCoordinator!.navVC, sut.masterNavVC)
    XCTAssertEqual(dCoordinator!.navVC, sut.detailNavVC)
    XCTAssertEqual(mCoordinator!.navVC.children.count, 1)
    XCTAssertEqual(dCoordinator!.navVC.children.count, 1)
    XCTAssertEqual(mCoordinator!.rootViewController, sut.masterRootVC)
    XCTAssertEqual(dCoordinator!.rootViewController, sut.detailRootVC)
  }
}
