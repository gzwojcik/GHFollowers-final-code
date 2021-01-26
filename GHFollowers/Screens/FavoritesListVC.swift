//
//  FavoritesListVC.swift
//  DHFollowers
//
//  Created by zgaga on 26/06/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

class FavoritesListVC: UIViewController {

    
    let tableView       = UITableView()
    var favorites:[Follower] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
        // because viewdid load wont reload if u go beetween screens. thats why view willAppear
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title               = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        // fill the whole view
        tableView.frame     = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    func getFavorites(){
        
        PersistenceManager.retrieveFavorites {[weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let favorites):
                
                if favorites.isEmpty {
                    self.showEmptyStateView(with: "No Favs?\nAdd one on the Follower screen.", in: self.view)
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        // bring the tableview to the front
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
                self.favorites = favorites
            case .failure(let error):
                self.presentGitHAlertOnMainThread(title: "Sth went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
        
    
  }


extension FavoritesListVC:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
        //how many?
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favourite = favorites[indexPath.row]
        cell.set(favorite: favourite)
        return cell
        //what to show?
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // this is to select the cell !
        let favourite = favorites[indexPath.row]
        let destVC = FollowerListVC()
        destVC.username = favourite.login
        destVC.title = favourite.login
        
        navigationController?.pushViewController(destVC, animated: true)
        
    }
    
    
    //deleting the cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
            
        let favourite   = favorites[indexPath.row]
        
        PersistenceManager.updateWith(favorite: favourite, actionType: .remove){ [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                // case when there's no error
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                // up is the local one, on this screen
                
                return
            }
            self.presentGitHAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
