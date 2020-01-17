//
//  Song.swift
//  Midterm-iOS
//
//  Created by Kai-Ta Hsieh on 2020/1/17.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import Foundation

struct Song: Decodable {
    
  let id: String
  let name: String
  let album: Album
}

struct Album: Decodable {
  
  let id: String
  let name: String
  let images: [Image]
  
}

struct Image: Decodable {
  
  let height: Int
  let width: Int
  let url: String
}
