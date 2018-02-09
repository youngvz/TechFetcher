//
//  Extensions.swift
//  TechFetcher
//
//  Created by Viraj Shah on 2/9/18.
//  Copyright © 2018 Jason Park. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImage(from url: String) {
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}
