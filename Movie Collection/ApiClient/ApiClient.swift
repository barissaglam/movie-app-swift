//
//  ApiClient.swift
//  Movie Collection
//
//  Created by BarisSaglam on 28.07.2019.
//  Copyright © 2019 BarisSaglam. All rights reserved.
//

import Alamofire


class ApiClient{
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (AFResult<T>)->Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T>) in
                completion(response.result)
        }
    }
    
    static func getPopularMovies(apiKey: String, completion:@escaping (AFResult<PopularMovies>)->Void) {
        let jsonDecoder = JSONDecoder()

        performRequest(route: APIRouter.retrievePopularMovies(api_key: apiKey), decoder: jsonDecoder, completion: completion)
    }
    
   
}
