//
//  ArticleCell.swift
//  TechFetcher
//
//  Created by Jason Park on 2/7/18.
//  Copyright © 2018 Jason Park. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var author: UILabel!
    
    
    var article: Article?{
        didSet{
            guard let article = article else { return }
            setupArticle(article)
        }
    }
    
    func setupArticle(_ article: Article){
        
        DispatchQueue.main.async {
            self.title.text = article.headline
            self.desc.text = article.desc
            self.author.text = article.author
            
            if let imageURL = article.imgUrl {
                self.imgView.downloadImage(from: imageURL)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
