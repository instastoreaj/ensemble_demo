//
//  RequestHandler.swift
//  Starwar_demo
//
//  Created by Mac on 9/15/21.
//

protocol RequestHandler {
    func getFilmsList(successHandler:@escaping(FilmsModel)->(), failHandler:@escaping(Error)->())
    func getDetail<T:Codable>(path: String, type:T.Type, successHandler:@escaping(T)->(), failHandler:@escaping(Error)->())
}
