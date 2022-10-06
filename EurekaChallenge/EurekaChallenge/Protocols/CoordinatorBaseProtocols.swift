//
//  CoordinatorBaseProtocols.swift
//  EurekaChallenge
//
//  Created by lolivera on 05/10/2022.
//
import Foundation

protocol Coordinator {
  func start()
}

protocol GenericCoordinator: Coordinator, GenericCoordinatorBase {
  func finish()
}

protocol MainCoordinator: Coordinator, MainCoordinatorBase {}
