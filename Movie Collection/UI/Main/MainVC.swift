//
//  MainVC.swift
//  Movie Collection
//
//  Created by BarisSaglam on 24.07.2019.
//  Copyright © 2019 BarisSaglam. All rights reserved.
//

import UIKit

class MainVC: BaseVC {
    struct Storyboard {
        static let nowPlayingMoviesCell = "NowPlayingTVCell"
        static let nowPlayingMoviesCollectionCell = "NowPlayingCVCell"
        static let popularTitleCell = "PopularMoviesTitleCell"
        static let popularMoviesCell = "PopularTVCell"
        static let popularMoviesCollectionCell = "PopularCVCell"
        static let latestTitleCell = "LatestMoviesTitleCell"
        static let latestMoviesCell = "LatestTVCell"
        static let latestMoviesCollectionCell = "LatestCVCell"
        static let popularActorsTitleCell = "PopularActorsTitleCell"
        static let popularActorsCell = "PopularActorsTVCell"
        static let popularActorsCollectionCell = "PopularActorsCVCell"
    }
    

    // MARK: -IBOutlet
    // -----
    @IBOutlet weak var mTableView: UITableView!
    
    // MARK: -Variables
    private lazy var viewModel: MainViewModel = {
        let vm = MainViewModel()
        vm.delegate = self
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationController()
        configureTableView()
        
        viewModel.retrievePopularMoviesRequest()
        
        // Do any additional setup after loading the view.
    }
    
    private func configureNavigationController(){
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Movie Collection"
        
    }
    
    private func configureTableView(){
        self.mTableView.estimatedRowHeight = self.mTableView.rowHeight
        self.mTableView.rowHeight = UITableView.automaticDimension
        self.mTableView.separatorStyle = UITableViewCell.SeparatorStyle.none;
    }
}

// ViewModelDelegate Extension
// -----
extension MainVC : MainViewModelDelegate{
    func onError(errorMsg: String) {
        print(errorMsg)
    }
    
    func popularMoviesLoaded(popularMovies: PopularMovies) {
        if let popularMoviesResult = popularMovies.results{
            for index in 0...popularMoviesResult.count-1{
                print(popularMoviesResult[index].title! + "\n")
            }
        }
    }
    
    
}

// TableView Extension
// -----
extension MainVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            let cell = mTableView.dequeueReusableCell(withIdentifier: Storyboard.nowPlayingMoviesCell, for: indexPath) as! NowPlayingTVCell
            return cell
        case 1:
            let cell = mTableView.dequeueReusableCell(withIdentifier: Storyboard.popularTitleCell, for: indexPath)
            return cell
        case 2:
            let cell = mTableView.dequeueReusableCell(withIdentifier: Storyboard.popularMoviesCell, for:indexPath) as! PopularTVCell
            return cell
        case 3:
            let cell = mTableView.dequeueReusableCell(withIdentifier: Storyboard.latestTitleCell, for:indexPath)
            return cell
        case 4:
            let cell = mTableView.dequeueReusableCell(withIdentifier: Storyboard.latestMoviesCell, for:indexPath) as! LatestTVCell
            return cell
        case 5:
            let cell = mTableView.dequeueReusableCell(withIdentifier: Storyboard.popularActorsTitleCell, for:indexPath)
            return cell
        case 6:
            let cell = mTableView.dequeueReusableCell(withIdentifier: Storyboard.popularActorsCell, for:indexPath) as! PopularActorsTVCell
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let cell = cell as? NowPlayingTVCell {
                
                cell.clvNowPlaying.showsHorizontalScrollIndicator = false
                cell.clvNowPlaying.reloadData()
                cell.clvNowPlaying.tag = indexPath.row
                
            }
        }
        
        if indexPath.row == 2 {
            if let cell = cell as? PopularTVCell {
                
                cell.clvPopular.showsHorizontalScrollIndicator = false
                cell.clvPopular.reloadData()
                cell.clvPopular.tag = indexPath.row
                
            }
        }
        
        if indexPath.row == 4 {
            if let cell = cell as? LatestTVCell {
                
                cell.clvLatest.showsHorizontalScrollIndicator = false
                cell.clvLatest.reloadData()
                cell.clvLatest.tag = indexPath.row
                
            }
        }
        
        if indexPath.row == 6 {
            if let cell = cell as? PopularActorsTVCell {
                
                cell.clvPopularActors.showsHorizontalScrollIndicator = false
                cell.clvPopularActors.reloadData()
                cell.clvPopularActors.tag = indexPath.row
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            if deviceSize == UIDeviceSize.i6_1Inch{
                return  197
            } else if deviceSize == UIDeviceSize.i4Inch{
                return 150
            } else{
                return 197
            }
            
        }
        else if indexPath.row == 2 || indexPath.row == 4{
            let cell = mTableView.dequeueReusableCell(withIdentifier: Storyboard.latestMoviesCell) as! LatestTVCell
            return cell.clvLatest.bounds.height
        }
        else if indexPath.row == 6{
            let cell = mTableView.dequeueReusableCell(withIdentifier: Storyboard.popularActorsCell) as! PopularActorsTVCell
            return cell.clvPopularActors.bounds.height
        }
        else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*  let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
         self.navigationController?.pushViewController(newViewController, animated: true)
         */
        mTableView.deselectRow(at: indexPath, animated: true)
    }
    
}


// CollectionView Extension
// -----
extension MainVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.nowPlayingMoviesCollectionCell , for: indexPath) as! NowPlayingCVCell
            return cell
        }
        else if collectionView.tag == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.popularMoviesCollectionCell, for: indexPath) as! PopularCVCell
            return cell
        }
        else if collectionView.tag == 4{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.latestMoviesCollectionCell, for: indexPath) as! LatestCVCell
            return cell
        }
        else if collectionView.tag == 6{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.popularActorsCollectionCell, for: indexPath) as! PopularActorsCVCell
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0{
            return CGSize(width: view.bounds.size.width, height: collectionView.bounds.height)
        }
        else if collectionView.tag == 6{
            return CGSize(width: 88.0, height: collectionView.frame.height)
        }
        else {
            return CGSize(width: 90.0, height: collectionView.frame.height)
        }
    }
    
    /*func scrollViewDidScroll(_ scrollView: UIScrollView)
     {
     let pageWidth = scrollView.frame.width
     self.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
     self.pageControlSwipe.currentPage = self.currentPage
     
     }*/
    
    
}
