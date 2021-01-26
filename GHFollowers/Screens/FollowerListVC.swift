//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by zgaga on 03/07/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit


class FollowerListVC: UIViewController {
    
    // collumns in view
    enum Section {
        case main
    }

    var username:String!
    var followers:[Follower] = []
    var filteredFollowers:[Follower] = []
    var page:Int =  1
    var hasMoreFollowers:Bool = true
    var isSearching:Bool = false
     
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Follower>!
     

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
        
           
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // to fix the navbar during the transition between screens.
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.create3columnFlowLayout(in: view))
        view.addSubview(collectionView)
        // delegate is listening to itself, wont work without it
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        //navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        #warning("nav bar's plus button is here !")
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        

    }

    func configureSearchController (){
        let searchController                                  = UISearchController()
        searchController.searchResultsUpdater                 = self
        searchController.searchBar.delegate                   = self
        searchController.searchBar.placeholder                = "Search for a username"
        // doesnt fade during search
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController                       = searchController
    }
    
    func getFollowers(username:String,page:Int){

        showLoadingView()

        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            #warning("call dismiss")

            
            //unwrap self so it wouldn't need optional
            guard let self = self else { return }
            self.dismissLoadingView()

                   switch result {
                   case .success(let followers):
                    // before it was a strong reference
                    if followers.count < 100 {self.hasMoreFollowers = false }
                    // checking if we have more than 1 screen - 100
                    self.followers.append(contentsOf: followers)

                    //check if the list is empty
                    #warning("add empy scr if no followers")
                    #warning("this is test of empty delete it !")
                    //self.followers = []
                    if self.followers.isEmpty{
                        let message = "This user doesn't have any followers"
                        DispatchQueue.main.async {
                             self.showEmptyStateView(with: message, in: self.view)
                        }
                        return

                    }
                    // add new followers to the array
                    self.updateData(on: self.followers)

                   case .failure(let error):
                    self.presentGitHAlertOnMainThread(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
                           // to access raw value of enum use .rewvalue
                   }
                 
               }
     
        
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }

    func updateData(on followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
        
        
    }
    
    @objc func addButtonTapped(){
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username){[weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistenceManager.updateWith(favorite: favorite, actionType: .add){[weak self] error in
                    guard let self = self else {return}
                    guard let error = error else {
                        // ctrl + cmd + space
                        self.presentGitHAlertOnMainThread(title: "Success!", message: "You have managed to save this user 🥳", buttonTitle: "Ok")
                        return
                    }
                    
                    self.presentGitHAlertOnMainThread(title: "Sth went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
                
                
            case.failure(let error):
                self.presentGitHAlertOnMainThread(title: "Sth went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
        
    }
    
}

extension FollowerListVC: UICollectionViewDelegate{
    // conforms to that delegate
    //sits n waits to be told to do sth
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //vertical scroll view if horisontal then x
        let offsetY     = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let screenHeight    = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            guard hasMoreFollowers else { return }
            //more than followers than 1 screen
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let activeArray     = isSearching ? filteredFollowers : followers
            let follower        = activeArray[indexPath.item]
            
            let destVC          = UserInfoVC()
            destVC.username     = follower.login
            destVC.delegate     = self
            let navController   = UINavigationController(rootViewController: destVC)
            present(navController, animated: true)
        }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)



    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // after clicking cancel goes back to the original followers array, not the filtered one.
        isSearching = false
        //stopped searching
        updateData(on: followers)
    }
}

extension FollowerListVC: UserInfoVCDelegate{
    func didRequestFollowers(for username: String) {
        // get followers for that user
        // reset everything
        self.username = username
        title         = username
        page          = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
        
        
    }
    
}
