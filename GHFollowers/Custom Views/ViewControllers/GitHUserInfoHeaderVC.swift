//
//  GitHUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by zgaga on 27/07/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

class GitHUserInfoHeaderVC: UIViewController {

    let avatarImageView = GitHAvatarImageView(frame: .zero)
    let usernameLabel = GitHFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GitHSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GitHSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GitHFBodyLabel(textAlignment: .left)

    var user:User!
    
    init(user:User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
        

    }
    
    func configureUIElements(){
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernameLabel.text          = user.login
        // if this is nil use this default value
        nameLabel.text              = user.name ?? "Not Available"
        locationLabel.text          = user.location ?? "No Location Available"
        bioLabel.text               = user.bio ?? "No Bio Available"
        bioLabel.numberOfLines      = 3
        
        
        // in constants enum
        locationImageView.image     = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
        
    }
    
    func addSubviews(){
        view.addSubviews(avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel)
//        view.addSubview(avatarImageView)
//        view.addSubview(usernameLabel)
//        view.addSubview(nameLabel)
//        view.addSubview(locationImageView)
//        view.addSubview(locationLabel)
//        view.addSubview(bioLabel)
        
    }
    
    func layoutUI(){
        let padding:CGFloat = 20
        let textImagePadding:CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            // sth new
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //location imageView
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //bioLabel
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
            
            
        ])
        
        
    }
    


}
