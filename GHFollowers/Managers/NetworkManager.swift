//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by zgaga on 22/07/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

class NetworkManager {

    // this is a singleton. every instance will have this variable shared
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    private let usersPerPage:Int = 100
    let cache = NSCache<NSString, UIImage>()

    private init(){}

    //closure, we get back list of followers or string with error
    // now with result type swift 5
    
    
    func getFollowers(for username: String, page:Int, completed:@escaping(Result<[Follower], GitHError>) -> Void){
        let endpoint = baseURL + "\(username)/followers?per_page=\(usersPerPage)&page=\(page)"

        guard let url = URL(string: endpoint)else {
            completed(.failure(.invalidUsername))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                //.self because it is a type
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        // this starts the network call
        task.resume()

    }
    
    
    
    func getUserInfo(for username: String, completed:@escaping(Result<User,GitHError>) -> Void){
        let endpoint = baseURL + "\(username)"

        guard let url = URL(string: endpoint)else {
            completed(.failure(.invalidUsername))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                //.self because it is a type
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        // this starts the network call
        task.resume()

    }
}
