//
//  GitHAvatarImageView.swift
//  GHFollowers
//
//  Created by zgaga on 27/07/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

class GitHAvatarImageView: UIImageView {

    let placeholderImage = UIImage(named: "avatar-placeholder")!
    //force unwrap it, it is in the bundle

    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        // rounded corners
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

}

