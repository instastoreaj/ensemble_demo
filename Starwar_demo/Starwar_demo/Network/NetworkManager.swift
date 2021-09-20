//
//  NetworkManager.swift
//  Starwar_demo
//
//  Created by Mac on 9/15/21.
//

import Foundation
import Alamofire

public class NetworkManager: RequestHandler {

    static let sharedInstance:NetworkManager = NetworkManager.init()
    
    private init() {}
    
    private func sendRequest<T:Codable>(_ request:BaseApiRequest, _ type:T.Type, successHandler:@escaping(T)->(), failHandler:@escaping(Error)->()) {
        AF.request(request.request()).responseDecodable { (response:AFDataResponse<T>) in
            switch response.result {
            case .success(let data):
                successHandler(data)
            case .failure(let error):
                failHandler(error)
            }
        }
    }
    
    func getFilmsList(successHandler: @escaping (FilmsModel) -> (), failHandler: @escaping (Error) -> ()) {
        let request = GetFilmRequest()
        sendRequest(request, FilmsModel.self, successHandler: successHandler, failHandler: failHandler)
    }
    
    func getDetail<T:Codable>(path: String, type:T.Type, successHandler:@escaping(T)->(), failHandler:@escaping(Error)->()) {
        let request = GetFilmRequest()
        request.requestPath = path
        sendRequest(request, T.self, successHandler: successHandler, failHandler: failHandler)
    }
}
