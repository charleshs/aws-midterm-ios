//
//  BannerView.swift
//  Midterm-iOS
//
//  Created by Kai-Ta Hsieh on 2020/1/17.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import UIKit

class HeaderView: UIView {

  let imgView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    return view
  }()
  
  private func setupImgView(image: UIImage?) {
    
    imgView.image = image
    addSubview(imgView)
    
    NSLayoutConstraint.activate([
      imgView.topAnchor.constraint(equalTo: topAnchor),
      imgView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imgView.trailingAnchor.constraint(equalTo: trailingAnchor),
      imgView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  init(frame: CGRect, image: UIImage?) {
    super.init(frame: frame)
    setupImgView(image: image)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}
