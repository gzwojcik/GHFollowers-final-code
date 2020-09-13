//
//  SceneDelegate.swift
//  DHFollowers
//
//  Created by zgaga on 25/06/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }




        // navigation controllers are placed in UITabbarController, navigation controllers hold  ViewControllers

        window = UIWindow (frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        // will create the tabbar and views
        window?.rootViewController = createTabbar()


        // shows the view
        window?.makeKeyAndVisible()
        configureNavigationBar()
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

    func createTabbar() -> UITabBarController{

        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        tabbar.viewControllers = [createSearchNC(), createFavouritesNC()]

        return tabbar
    }

    func configureNavigationBar(){
        UINavigationBar.appearance().tintColor = .systemGreen
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

