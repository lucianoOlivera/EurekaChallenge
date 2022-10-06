//
//  CoordinatorBaseTests.swift
//  EurekaChallengeTests
//
//  Created by lolivera on 06/10/2022.
//
import XCTest

@testable import class EurekaChallenge.CoordinatorBase
@testable import class EurekaChallenge.GenericCoordinatorBase

class CoordinatorBaseTests: XCTestCase, TestBase {
  var sut: CoordinatorBase!
  var coordinatorBase: GenericCoordinatorBase!
  
  override func setUp() {
    super.setUp()
    self.sut = CoordinatorBase()
    self.coordinatorBase = GenericCoordinatorBase(rootViewController: UIViewController(), navVC: UINavigationController())
  }
  
  override func tearDown() {
    self.sut = nil
    self.coordinatorBase = nil
    super.tearDown()
  }
  
  func testPushCoordinatorSetsTheCorrectParent() {
    self.sut.pushCoordinator(coordinator: &coordinatorBase,
                             rootVC: coordinatorBase.rootViewController, animated: false)
    
    XCTAssertEqual(sut.childCoordinators.count, 1)
    XCTAssertEqual(sut.childCoordinators.first, coordinatorBase)
    XCTAssertEqual(sut.childCoordinators.first!.parentCordinator, sut)
  }
  
  func testPushCoordinatorSetsTheCorrectNavigationFlow() {
    self.sut.pushCoordinator(coordinator: &coordinatorBase,
                             rootVC: coordinatorBase.rootViewController, animated: false)
    self.coordinatorBase.navVC.pushViewController(UIViewController(), animated: false)
    
    XCTAssertEqual(sut.childCoordinators.first!.navVC.children.count, 2)
    XCTAssertEqual(sut.childCoordinators.first!.navVC.children.first, coordinatorBase.rootViewController)
  }
  
  func testPopCoordinatorRemovesTheCorrectCoordinator() {
    self.givenACoordinatorBaseWithTwoChildCoordinator()
    
    let lastChild = self.sut.childCoordinators.last
    self.sut.popCoordinator(coordinator: lastChild!, animated: false)
    
    XCTAssertEqual(sut.childCoordinators.count, 1)
    XCTAssertFalse(sut.childCoordinators.first === lastChild)
  }
  
  func testPopCoordinatorRemovesAllViewConctrollersContainedInAChild() {
    self.givenACoordinatorBaseWithTwoChildCoordinatorsWithTwoViewControllers()
    
    let child = self.sut.childCoordinators.last
    self.sut.popCoordinator(coordinator: child!, animated: false)
    
    XCTAssertEqual(sut.childCoordinators.count, 1)
    XCTAssertEqual(sut.childCoordinators.first!.navVC.children.count, 2)
  }
  
  func givenACoordinatorBaseWithTwoChildCoordinator() {
    var secondCoordinatorBase = GenericCoordinatorBase(rootViewController: UIViewController(), navVC: self.coordinatorBase.navVC)
    self.sut.pushCoordinator(coordinator: &coordinatorBase,
                             rootVC: coordinatorBase.rootViewController,
                             animated: false)
    self.sut.pushCoordinator(coordinator: &secondCoordinatorBase,
                             rootVC: secondCoordinatorBase.rootViewController,
                             animated: false)
  }
  
  func givenACoordinatorBaseWithTwoChildCoordinatorsWithTwoViewControllers() {
    self.sut.pushCoordinator(coordinator: &coordinatorBase,
                             rootVC: coordinatorBase.rootViewController,
                             animated: false)
    self.coordinatorBase.navVC.pushViewController(UIViewController(), animated: false)
    
    var secondCoordinatorBase = GenericCoordinatorBase(rootViewController: UIViewController(), navVC: self.coordinatorBase.navVC)
    
    self.sut.pushCoordinator(coordinator: &secondCoordinatorBase,
                             rootVC: secondCoordinatorBase.rootViewController,
                             animated: false)
    secondCoordinatorBase.navVC.pushViewController(UIViewController(), animated: false)
  }
}
