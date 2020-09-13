//
//  GitHAvatarImageView.swift
//  GHFollowers
//
//  Created by zgaga on 27/07/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

class GitHAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
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
    
    func downloadImage(from urlString: String) {
        
        // check if we have the image in cache, if not then download
        
        let cacheKey = NSString(string: urlString)
        // identify each object by its url
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            //weak self requirement
            guard let self = self else { return }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            // not handling the errors, placeholder image is enough
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            // if we have it set the image to cache
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }

}

