//
//  ViewController.swift
//  Midterm-iOS
//
//  Created by Kai-Ta Hsieh on 2020/1/17.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let auth = AuthManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    auth.getToken { (result) in
      switch result {
      case .success(let token):
        print(token.accessToken)
      case .failure(let error):
        print(error)
      }
    }
    
  }


}

