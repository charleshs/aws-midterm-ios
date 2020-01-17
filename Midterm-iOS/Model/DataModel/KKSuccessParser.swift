//
//  KKSuccessParser.swift
//  Midterm-iOS
//
//  Created by Kai-Ta Hsieh on 2020/1/17.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import Foundation

struct KKSuccessParser: Decodable {
  
  let data: [Song]
  let paging: Paging
  let summary: Summary
}
