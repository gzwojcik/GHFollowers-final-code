//
//  User.swift
//  GHFollowers
//
//  Created by zgaga on 18/07/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

struct User:Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
    

// hold alt for column change
// everything not optional should be let
}
