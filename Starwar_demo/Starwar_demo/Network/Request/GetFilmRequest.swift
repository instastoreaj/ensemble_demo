//
//  GetFilmRequest.swift
//  Starwar_demo
//
//  Created by Mac on 9/16/21.
//

import Foundation

class GetFilmRequest: BaseApiRequest {
    public var requestBodyObject: BaseObject?
    public var requestMethod: RequestHttpMethod?
    public var requestPath: String = ""
}
