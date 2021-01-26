//
//  GitHTabBarController.swift
//  GHFollowers
//
//  Created by zgagaSur on 10/11/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

class GitHTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGreen
        
        viewControllers                 = [createSearchNC(), createFavouritesNC()]

        // Do any additional setup after loading the view.
    }

    func createSearchNC() -> UINavigationController {
        // always use the local variable, not the class.
        let searchVC = SearchVC()
        searchVC.title = "Search"
        // system tab bar with 1st possition
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        return UINavigationController(rootViewController: searchVC)
        
    }


    func createFavouritesNC() -> UINavigationController {
        let favouritesListVC = FavoritesListVC()
        favouritesListVC.title = "Favourites"
        favouritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        return UINavigationController(rootViewController: favouritesListVC)
    }

    
}
