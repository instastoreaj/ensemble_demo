//
//  BaseApiRequest.swift
//  Starwar_demo
//
//  Created by Mac on 9/15/21.
//

import Foundation
import Alamofire

protocol BaseApiRequest {
    var requestMethod: RequestHttpMethod? { get }
    var requestBodyObject: BaseObject? { get }
    var requestPath: String { get }
    func request() -> URLRequest
}

extension BaseApiRequest {
    var baseUrl: String {
        return "https://swapi.dev/api/films"
    }
    
    func request() -> URLRequest {
        var url: URL?
        if requestPath.isEmpty {
            url = URL(string: baseUrl)
        } else {
            url = URL(string: requestPath)
        }
        
        var request = URLRequest(url: url!)
        request.timeoutInterval = 15

        switch requestMethod {
        case .Get:
            request.httpMethod = HTTPMethod.get.rawValue
            break
        case .Post:
            request.httpMethod = HTTPMethod.post.rawValue
            if requestBodyObject != nil {
                let jsonEncoder = JSONEncoder()
                do {
                    request.httpBody = try jsonEncoder.encode(requestBodyObject)
                } catch  {
                    print(error)
                }
            }
            break
        default:
            request.httpMethod = HTTPMethod.get.rawValue
            break
        }
        
        return request
    }
}

public enum RequestHttpMethod {
    case Get
    case Post
}
