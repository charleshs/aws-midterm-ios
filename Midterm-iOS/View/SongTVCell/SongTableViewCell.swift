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
  
  var viewModel: SongViewModel?
  
  @IBOutlet weak var songImgView: UIImageView!
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var favoriteBtn: UIButton!
  
  @IBAction func didTapFavoriteBtn(_ sender: Any) {
        
    viewModel?.isFavorite.value.toggle()
  }
  
  func layoutCell(with viewModel: SongViewModel) {
    
    self.viewModel = viewModel
    
    titleLabel.text = viewModel.songTitle
    
    songImgView.loadImage(urlString: viewModel.imageUrlString)
    
    viewModel.isFavorite.addObserver { [weak self] isFavorite in
      
      self?.favoriteBtn.isSelected = isFavorite
      
      self?.favoriteBtn.tintColor = isFavorite ? .systemPink : .darkGray
    }
    
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    viewModel?.isFavorite.removeObserver()
  }
  
}
