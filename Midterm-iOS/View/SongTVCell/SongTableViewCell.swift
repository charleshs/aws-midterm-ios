//
//  SongTableViewCell.swift
//  Midterm-iOS
//
//  Created by Kai-Ta Hsieh on 2020/1/17.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
  static var identifier: String {
    return String(describing: SongTableViewCell.self)
  }
  
  @IBOutlet weak var songImgView: UIImageView!
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var favoriteBtn: UIButton!
  
  
  @IBAction func didTapFavoriteBtn(_ sender: Any) {
  }
  
}
