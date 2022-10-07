//
//  PhotoDetailsViewController.swift
//  EurekaChallenge
//
//  Created by lolivera on 05/10/2022.
//

import UIKit

protocol PhotoDetailsViewControllerDelegate {
  func photoDetailsVCDidSelectBackButton()
}

class PhotoDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


  var delegate: PhotoDetailsViewControllerDelegate?

}
