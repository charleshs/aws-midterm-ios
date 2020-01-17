//
//  PlaylistProvider.swift
//  Midterm-iOS
//
//  Created by Kai-Ta Hsieh on 2020/1/17.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import Foundation

typealias PlaylistResult = (Result<[Song], Error>) -> Void

class PlaylistProvider {
  
  private let limit = 20
  
  private var nextOffset = 0
  
  var hasNextPage: Bool = true
  
  /// isRefreshing is `false` by default. Set to `true` if you want to refresh data.
  func fetchPlaylist(isRefreshing: Bool = false,
                     completion: @escaping PlaylistResult) {
    
    guard let accessToken = AuthManager.shared.token?.accessToken else { return }
    
    nextOffset = isRefreshing ? 0 : nextOffset
    
    let request = KKRequest.playlist(token: accessToken, limit: limit, offset: nextOffset)
    
    HTTPClient.shared.request(request) { [weak self] (result) in
      
      switch result {
      case .success(let data):
        guard let self = self else { return }
        
        let parseResult = parseJSON(KKSuccessParser.self, from: data)
        
        switch parseResult {
        case .success(let parser):

          if parser.paging.next != nil {
            self.nextOffset += self.limit
          } else {
            self.hasNextPage = false
          }
          
          completion(.success(parser.data))
          
        case .failure(let error):
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
}
