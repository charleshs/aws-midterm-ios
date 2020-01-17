//
//  KKRequest.swift
//  Midterm-iOS
//
//  Created by Kai-Ta Hsieh on 2020/1/17.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import Foundation

enum KKRequest: RequestMaker {
  
  case auth
  
  case playlist(token: String, limit: Int, offset: Int)
  
  var headers: [String: String] {
    switch self {
      
    case .auth:
      return ["Content-Type": "application/x-www-form-urlencoded"]
      
    case .playlist(let token, _, _):
      return [
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Bearer \(token)"
      ]
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
      
      return getParameterString(params: params).data(using: .utf8)
      
    case .playlist:
      return nil
    }
  }
  
  var method: String {
    switch self {
      
    case .auth:
      return "POST"
      
    case .playlist:
      return "GET"
    }
  }
  
  var urlString: String {
    switch self {
      
    case .auth:
      return "https://account.kkbox.com/oauth2/token"
      
    case .playlist(_, let limit, let offset):
      let baseUrl = "https://api.kkbox.com/v1.1/new-hits-playlists"
      let playlistID = "/DZrC8m29ciOFY2JAm3/tracks?"
      let params: [String: Any] = [
        "territory": "TW",
        "limit": String(limit),
        "offset": String(offset)
      ]
      return baseUrl + playlistID + getParameterString(params: params)
    }
  }
  
  func getParameterString(params: [String: Any]) -> String {
    var data = [String]()
    for(key, value) in params
    {
      data.append(key + "=\(value)")
    }
    return data.map { String($0) }.joined(separator: "&")
  }
  
}
