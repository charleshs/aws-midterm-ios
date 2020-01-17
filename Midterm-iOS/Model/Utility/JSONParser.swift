//
//  JSONParser.swift
//  KDLibrary
//
//  Created by Kai-Ta Hsieh on 2020/1/8.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import Foundation



func parseJSON<T: Decodable>(_ type: T.Type, from data: Data) -> Result<T, Error> {
  
  let decoder = JSONDecoder()
  do {
    let parseResult = try decoder.decode(T.self, from: data)
    return .success(parseResult)
  } catch {
    return .failure(error)
  }
}


