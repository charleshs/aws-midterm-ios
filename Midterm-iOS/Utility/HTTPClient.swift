//
//  HTTPClient.swift
//  KDLibrary
//
//  Created by Kai-Ta Hsieh on 2020/1/8.
//  Copyright © 2020 Kai-Ta Hsieh. All rights reserved.
//

import Foundation

enum HTTPClientError: Error {
  
  case clientError(Data)
  
  case serverError
  
  case unexpectedError
}

protocol RequestMaker {
  
  var headers: [String: String] { get }
  
  var body: Data? { get }
  
  var method: String { get }
  
  var urlString: String { get }
}

extension RequestMaker {
  
  func makeRequest() -> URLRequest {
    
    guard let url = URL(string: urlString) else {
      fatalError("* Failure parsing URL: \(urlString)")
    }
    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = headers
    request.httpBody = body
    request.httpMethod = method
    return request
  }
  
}

class HTTPClient {
  
  static let shared = HTTPClient()
  
  private init() { }
  
  func request(_ request: RequestMaker,
               completion: @escaping (Result<Data, Error>) -> Void) {
    
    URLSession.shared.delegateQueue.maxConcurrentOperationCount = 10
    
    URLSession.shared.dataTask(
      with: request.makeRequest(),
      completionHandler: { (data, response, error) in
        
        guard error == nil,
          let data = data,
          let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            return completion(.failure(error!))
        }
        switch statusCode {
        case 200 ..< 300:
          completion(.success(data))
        case 400 ..< 500:
          completion(.failure(HTTPClientError.clientError(data)))
        case 500 ..< 600:
          completion(.failure(HTTPClientError.serverError))
        default:
          completion(.failure(HTTPClientError.unexpectedError))
        }
    }).resume()
  }
  
}
