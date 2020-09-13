//
//  User.swift
//  GHFollowers
//
//  Created by zgaga on 18/07/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

struct User:Codable {
    var login:String
    var avatarUrl:String
    var name:String?
    var location:String?
    var bio:String?
    var publicRepos:Int
    var publicGists:Int
    var htmlUrl:String
    var following:Int
    var followers:Int
    var created_at:String
    


}
