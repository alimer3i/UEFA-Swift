//
//  AppStoreAPI.swift
//  VirtualNumber
//
//  Created by Joe Maghzal on 29/06/2022.
//

import Foundation
import Alamofire

enum AppStoreAPI: URLRequestBuilder {
    case appStoreId
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
    var path: String {
        return "/lookup"
    }
    var parameters: Parameters? {
        return [
            "bundleId": Bundle.main.bundleIdentifier ?? ""
        ]
    }
    var headers: HTTPHeaders {
        return HTTPHeaders()
    }
    var method: HTTPMethod {
        return .get
    }
}
