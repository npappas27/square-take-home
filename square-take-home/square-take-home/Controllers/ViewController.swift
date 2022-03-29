//
//  ViewController.swift
//  square-take-home
//
//  Created by Nick Pappas on 3/29/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        NetworkManager.shared.downloadEmployees { result in
            switch result {
            case .success(let employees):
                print(employees)
            case .failure(let error):
                print(error)
            }
        }
    }
}

