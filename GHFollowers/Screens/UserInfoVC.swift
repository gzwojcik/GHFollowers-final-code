//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by zgagaSur on 17/09/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit



protocol  UserInfoVCDelegate:class {
    func didTapGitHubProfile(for user:User)
    func didTapGetFollowers(for user:User)
    
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GitHFBodyLabel(textAlignment: .center)
    var itemViews:[UIView] = []
    
    var username: String!
    weak var delegate:FollowerListVCDelegate!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        configureViewController()
        layoutUI()
        getUserInfo()
    
       
       
        
    }
    
    
    func configureViewController(){
        
        view.backgroundColor = .systemBackground
        
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismssVC))
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    
    func getUserInfo(){
        
        NetworkManager.shared.getUserInfo(for: username){ [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
                
            case .failure(let error):
                self.presentGitHAlertOnMainThread(title: "Sth went wrong", message: error.rawValue, buttonTitle: "OK")
                
            }
            
        }
        
    }
    
    func configureUIElements(with user:User) {
        let repoItemVC      = GitHRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC      = GitHFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.add(childVC: GitHUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
        //self.dateLabel.text = user.createdAt
        
    }
    
    func layoutUI(){
        
        let padding :CGFloat = 20
        let itemHeight:CGFloat = 140
        
        itemViews = [headerView,itemViewOne,itemViewTwo,dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            
            ])
        }
        
        
        //itemViewOne.backgroundColor = .systemPink
        //itemViewTwo.backgroundColor = .systemBlue
        
        
        
       
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant:itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant:itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func add(childVC:UIViewController, to containerView:UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismssVC() {
        dismiss(animated: true)
    }

 
}

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitHubProfile(for user: User) {
        // show Safari VC
        guard let url = URL(string: user.htmlUrl) else {
            presentGitHAlertOnMainThread(title: "Invalid URL", message: "This user's url is invalid.", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        //dissmiss this vc
        //get follower list for the new user
        
        guard user.followers != 0 else {
            presentGitHAlertOnMainThread(title: "No followers", message: "This user has no followes", buttonTitle: "Ok")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismssVC()
        
    }
    
    
    
}