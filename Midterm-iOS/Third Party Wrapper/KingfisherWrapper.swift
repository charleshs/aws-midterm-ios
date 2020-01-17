//
//  KingfisherWrapper.swift
//  Midterm-iOS
//
//  Created by Kai-Ta Hsieh on 2020/1/17.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
  
  func loadImage(urlString: String) {
    let url = URL(string: urlString)
    kf.setImage(with: url)
  }
  
}
