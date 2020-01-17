//
//  Paging.swift
//  Midterm-iOS
//
//  Created by Kai-Ta Hsieh on 2020/1/17.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import Foundation

struct Paging: Decodable {
  
  let offset: Int
  let limit: Int
  let previous: String?
  let next: String?
}
