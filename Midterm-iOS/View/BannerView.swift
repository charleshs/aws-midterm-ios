//
//  BannerView.swift
//  Midterm-iOS
//
//  Created by Kai-Ta Hsieh on 2020/1/17.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import UIKit

class BannerView: UIView {
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalTo: widthAnchor).isActive = true
  }
}
