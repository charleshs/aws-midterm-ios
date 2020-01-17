//
//  AuthManager.swift
//  Midterm-iOS
//
//  Created by Kai-Ta Hsieh on 2020/1/17.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import Foundation

typealias TokenResult = (Result<Token, Error>) -> Void

class AuthManager {
  
  func getToken(completion: @escaping TokenResult) {
    let request = KKBoxRequest.auth
    
    HTTPClient.shared.request(request) { (result) in
      switch result {
        
      case .success(let data):
        let parseResult = parseJSON(Token.self, from: data)
        
        completion(parseResult)
        
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
    
}
