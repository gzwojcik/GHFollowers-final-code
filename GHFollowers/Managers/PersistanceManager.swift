//
//  PersistanceManager.swift
//  GHFollowers
//
//  Created by zgagaSur on 27/10/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

enum PersistenceActionType{
    case add, remove
}



enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite:Follower, actionType:PersistenceActionType, completed: @escaping (GitHError?)-> Void){
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retreivedFavorites = favorites
                
                
             
                switch actionType {
                case .add:
                    guard !retreivedFavorites.contains(favorite)else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    // save the new fav into the fav
                    retreivedFavorites.append(favorite)
                    
                    
                case .remove:
                    // compare logins, then remove
                    retreivedFavorites.removeAll {$0.login == favorite.login}
                }
                
                //retreived fav
                completed(save(favorites: retreivedFavorites))
                
                
                
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GitHError>)-> Void){
        // if we use non stdard types we have to encodeit and decode it
        
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            // if running it fo the 1st time
            completed(.success([]))
            return
        }
        
        do {

            let decoder = JSONDecoder()
         
            //.self because it is a type
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
        
    }
    
    static func save(favorites:[Follower]) -> GitHError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            // because there is no gitHerror to return
            return nil
        } catch {
            return .unableToFavorite
        }
        
        
    }
}
