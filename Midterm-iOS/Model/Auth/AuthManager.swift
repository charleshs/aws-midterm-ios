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
  
  static let shared = AuthManager()
  
  var token: Token? {
    guard let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String,
      let tokenType = UserDefaults.standard.value(forKey: "tokenType") as? String,
      let expiresIn = UserDefaults.standard.value(forKey: "expiresIn") as? Int else { return nil }
    
    return Token(accessToken: accessToken, tokenType: tokenType, expiresIn: expiresIn)
  }
  
  private init() { }
  
  func getToken(completion: @escaping TokenResult) {
    let request = KKRequest.auth
    
    HTTPClient.shared.request(request) { result in
      switch result {
        
      case .success(let data):
        let parseResult = parseJSON(Token.self, from: data)
        
        switch parseResult {
          
        case .success(let token):
          UserDefaults.standard.setValue(token.accessToken, forKey: "accessToken")
          UserDefaults.standard.setValue(token.tokenType, forKey: "tokenType")
          UserDefaults.standard.setValue(token.expiresIn, forKey: "expiresIn")
          completion(.success(token))
          
        case .failure(let error):
          completion(.failure(error))
        }
        
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
    
}
