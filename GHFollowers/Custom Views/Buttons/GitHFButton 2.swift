//
//  GitHFButton.swift
//  DHFollowers
//
//  Created by zgaga on 30/06/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

class GitHFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(backgroundColor:UIColor, title:String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()

    }


    private func configure (){
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
        // USE AUTO LAYOUT programatic constraints
        translatesAutoresizingMaskIntoConstraints = false
    }
}
