//
//  ErrorMsgEnum.swift
//  GHFollowers
//
//  Created by zgaga on 23/07/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

// raw value - all values associate to 1 type
// associated value - different types after each case in ()
// conforms to an error protocol
enum GitHError:String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete request. Check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received was invalid. Try again."
}
