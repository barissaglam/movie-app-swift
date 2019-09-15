//
//  APIRouter.swift
//  Movie Collection
//
//  Created by BarisSaglam on 28.07.2019.
//  Copyright © 2019 BarisSaglam. All rights reserved.
//

import Alamofire

enum APIRouter: URLRequestConvertible{
    case retrievePopularMovies(api_key: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self{
        case .retrievePopularMovies:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .retrievePopularMovies :
            return "/movie/popular"
        }
    }
    
    // MARK: - Parameters
   /* private var parameters: Parameters?{
        switch self{
        case .retrievePopularMovies(let api_key):
            return
        }
    }
    
    */
    
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        /*
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }*/
        
        switch self {
        case .retrievePopularMovies(let apiKey):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: ["api_key": apiKey])
        }
        
        return urlRequest
    }
    

}


