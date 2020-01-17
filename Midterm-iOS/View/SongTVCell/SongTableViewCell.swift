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
    

    guard let viewModel = viewModel else { return }
    
    viewModel.isFavorite.toggle()
    favoriteBtn.isSelected = viewModel.isFavorite
    favoriteBtn.tintColor = viewModel.isFavorite ? .systemPink : .darkGray
    
    layoutIfNeeded()
  }
  
  func layoutCell(with viewModel: SongViewModel) {
    
    self.viewModel = viewModel
    titleLabel.text = viewModel.songTitle
    songImgView.loadImage(urlString: viewModel.imageUrlString)
    
    favoriteBtn.isSelected = viewModel.isFavorite
    favoriteBtn.tintColor = viewModel.isFavorite ? .systemPink : .darkGray
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
}
