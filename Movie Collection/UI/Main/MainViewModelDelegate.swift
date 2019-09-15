//
//  MainViewModelDelegate.swift
//  Movie Collection
//
//  Created by BarisSaglam on 28.07.2019.
//  Copyright © 2019 BarisSaglam. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate {
    func onError(errorMsg: String)
    func popularMoviesLoaded(popularMovies: PopularMovies)
}
