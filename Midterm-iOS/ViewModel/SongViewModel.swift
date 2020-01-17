//
//  SongViewModel.swift
//  Midterm-iOS
//
//  Created by Kai-Ta Hsieh on 2020/1/17.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import Foundation

class SongViewModel {
  
  let songTitle: String
  
  let imageUrlString: String
  
  var isFavorite = Observable<Bool>(value: false)
  
  init(songTitle: String, imageUrlString: String) {
    
    self.songTitle = songTitle
    self.imageUrlString = imageUrlString
  }
}
