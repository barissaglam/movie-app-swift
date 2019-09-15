//
//  MainViewModel.swift
//  Movie Collection
//
//  Created by BarisSaglam on 28.07.2019.
//  Copyright © 2019 BarisSaglam. All rights reserved.
//

import Foundation

class MainViewModel : BaseViewModel{
    var delegate: MainViewModelDelegate?
    
    
    func retrievePopularMoviesRequest(){
        ApiClient.getPopularMovies(apiKey: apiKey) { (result) in
            switch result {
            case .success(let popularMovies):
                self.delegate?.popularMoviesLoaded(popularMovies: popularMovies)
                
            case .failure(let error):
                print(error)
                self.delegate?.onError(errorMsg: "Unknown an error...")
            }
        }
    }
}
