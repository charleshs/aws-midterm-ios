//
//  KKBoxRequest.swift
//  Midterm-iOS
//
//  Created by Kai-Ta Hsieh on 2020/1/17.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import Foundation

enum KKBoxRequest: RequestMaker {
  
  case auth
  
//  case hits
  
  var headers: [String: String] {
    switch self {
    
    case .auth:
      return ["Content-Type": "application/x-www-form-urlencoded"]
      
//    case .hits:
//      return []
    }
  }
  
  var body: Data? {
    switch self {
      
    case .auth:
      let params: [String: Any] = [
        "grant_type": "client_credentials",
        "client_id": "e993e436bc881c257d3cfce8125bdaeb",
        "client_secret": "844aa6e18160d9b9604e9b98ae71e3e3"
      ]
      
      return getPostString(params: params).data(using: .utf8)
    }
  }
  
  var method: String {
    switch self {
  
    case .auth:
      return "POST"
    }
  }
  
  var urlString: String {
    switch self {
    
      case .auth:
        return "https://account.kkbox.com/oauth2/token"
      }
  }
  
  func getPostString(params: [String: Any]) -> String {
      var data = [String]()
      for(key, value) in params
      {
          data.append(key + "=\(value)")
      }
      return data.map { String($0) }.joined(separator: "&")
  }
  
}
