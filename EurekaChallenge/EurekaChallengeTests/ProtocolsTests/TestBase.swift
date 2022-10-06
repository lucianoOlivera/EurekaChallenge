//
//  TestBase.swift
//  EurekaChallengeTests
//
//  Created by lolivera on 06/10/2022.
//

import Foundation

protocol TestBase {
  associatedtype SystemUnderTest
    /// The system under test(AKA: sut) represents
    /// the object intended to test.
    /// reference : https://www.netguru.com/blog/testing-swift-ios-navigation
  var sut: SystemUnderTest! { get set }
}
