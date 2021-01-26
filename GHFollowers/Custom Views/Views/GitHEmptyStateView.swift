//
//  GitHEmptyStateView.swift
//  GHFollowers
//
//  Created by zgaga on 09/09/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

class GitHEmptyStateView: UIView {

    let messageLabel = GitHFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()

    let logoImageBCGname:String = "empty-state-logo"

   override init(frame:CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init (message:String){
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }

    private func configure (){
        addSubviews(messageLabel, logoImageView)
        
//        addSubview(messageLabel)
//        addSubview(logoImageView)

        messageLabel.numberOfLines = 3
        messageLabel.textColor     = .secondaryLabel

        logoImageView.image = UIImage(named: logoImageBCGname)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            // moved up 150 pixels
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant:  -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),

            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])


    }

}
