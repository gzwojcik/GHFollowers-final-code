//
//  GitHItemInfoVC.swift
//  GHFollowers
//
//  Created by zgagaSur on 11/10/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

protocol  ItemInfoVCDelegate:class {
    func didTapGitHubProfile(for user:User)
    func didTapGetFollowers(for user:User)
    
}

class GitHItemInfoVC: UIViewController {

    let stackView       = UIStackView()
    let itemInfoViewOne = GitHItemInfoView()
    let itemInfoViewTwo = GitHItemInfoView()
    let actionButton    = GitHFButton()
    // without constructor, its only a generic button in super class, not a specific one, those come in child views
    
    var user: User!
    
    
    init(user:User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
        configureActionButton()

        
    }
    
    private func configureBackgroundView(){
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
        
    }
    
    private func configureStackView(){
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
        
    }
    
    private func configureActionButton(){
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped(){
        // generic super class, this has to be overwritten by children classes
    }
    
    private func layoutUI(){
        
        // using UIView extension
        
        view.addSubviews(stackView, actionButton)
        
        // old way, just for reference
        
//        view.addSubview(stackView)
//        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
            
            
        
        ])
        
    }

}
