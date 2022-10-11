//
//  CoordinatorBaseTests.swift
//  EurekaChallengeTests
//
//  Created by lolivera on 06/10/2022.
//
import XCTest

@testable import class EurekaChallenge.CoordinatorBase
@testable import class EurekaChallenge.GenericCoordinatorBase

class CoordinatorBaseTests: XCTestCase, TestBaseSystem {
  var sut: CoordinatorBase!
  var genericCoordinatorBase: GenericCoordinatorBase!
    
  override func tearDown() {
    self.sut = nil
    self.genericCoordinatorBase = nil
    super.tearDown()
  }
  
  override func setUp() {
    super.setUp()
    self.sut = CoordinatorBase()
    self.genericCoordinatorBase = GenericCoordinatorBase(rootViewController: UIViewController(), navVC: UINavigationController())
  }
  
  func testPushCoordinatorSetsTheCorrect() {
    self.sut.pushCoordinatorFrom(coordinator: &genericCoordinatorBase,
                             rootVC: genericCoordinatorBase.rootViewController, animated: false)
    
    XCTAssertEqual(sut.childCoordinators.count, 1)
    XCTAssertEqual(sut.childCoordinators.first, genericCoordinatorBase)
    XCTAssertEqual(sut.childCoordinators.first!.parentCordinator, sut)
  }
  
  func testPushCoordinatorSetsFlow() {
    self.sut.pushCoordinatorFrom(coordinator: &genericCoordinatorBase,
                             rootVC: genericCoordinatorBase.rootViewController, animated: false)
    self.genericCoordinatorBase.navVC.pushViewController(UIViewController(), animated: false)
    
    XCTAssertEqual(sut.childCoordinators.first!.navVC.children.count, 2)
    XCTAssertEqual(sut.childCoordinators.first!.navVC.children.first, genericCoordinatorBase.rootViewController)
  }
  
  func testPopCoordinatorRemoves() {
    self.givenACoordinatorBaseWithTwoChildCoordinator()
    
    let lastChild = self.sut.childCoordinators.last
    self.sut.popCoordinatorFrom(coordinator: lastChild!, animated: false)
    
    XCTAssertEqual(sut.childCoordinators.count, 1)
    XCTAssertFalse(sut.childCoordinators.first === lastChild)
  }
  
  func testPopCoordinatorRemovesAllViewInAChild() {
    self.givenACoordinatorBaseWithTwoChildCoordinators()
    
    let child = self.sut.childCoordinators.last
    self.sut.popCoordinatorFrom(coordinator: child!, animated: false)
    
    XCTAssertEqual(sut.childCoordinators.count, 1)
    XCTAssertEqual(sut.childCoordinators.first!.navVC.children.count, 2)
  }
  
  func givenACoordinatorBaseWithTwoChildCoordinator() {
    var secondCoordinatorBase = GenericCoordinatorBase(rootViewController: UIViewController(), navVC: self.genericCoordinatorBase.navVC)
    self.sut.pushCoordinatorFrom(coordinator: &genericCoordinatorBase,
                             rootVC: genericCoordinatorBase.rootViewController,
                             animated: false)
    self.sut.pushCoordinatorFrom(coordinator: &secondCoordinatorBase,
                             rootVC: secondCoordinatorBase.rootViewController,
                             animated: false)
  }
  
  func givenACoordinatorBaseWithTwoChildCoordinators() {
    self.sut.pushCoordinatorFrom(coordinator: &genericCoordinatorBase,
                             rootVC: genericCoordinatorBase.rootViewController,
                             animated: false)
    self.genericCoordinatorBase.navVC.pushViewController(UIViewController(), animated: false)
    
    var secondCoordinatorBase = GenericCoordinatorBase(rootViewController: UIViewController(), navVC: self.genericCoordinatorBase.navVC)
    
    self.sut.pushCoordinatorFrom(coordinator: &secondCoordinatorBase,
                             rootVC: secondCoordinatorBase.rootViewController,
                             animated: false)
    secondCoordinatorBase.navVC.pushViewController(UIViewController(), animated: false)
  }
}
