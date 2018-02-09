//
//  ViewController.swift
//  TechFetcher
//
//  Created by Jason Park on 2/7/18.
//  Copyright © 2018 Jason Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var tableview: UITableView!
    
    var articlesArray = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
        setupNavBar()
    }
    
    func setupNavBar(){
        navigationController?.navigationBar.barTintColor = UIColor(red:0.48, green:0.84, blue:0.99, alpha:1.00)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "KohinoorBangla-Light", size: 26)!,NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationItem.title = "TechFetch"
    }
    
}

extension ViewController:  UITableViewDelegate, UITableViewDataSource {
    
    // MARK: TableView Delegates
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        cell.article = articlesArray[indexPath.item]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articlesArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = WebViewController()
        webVC.urlString = articlesArray[indexPath.item].url
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}


extension ViewController {
    
    
    // MARK: Network Requests
    
    func fetchArticles() {
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=600327379ddc468db9d7a55a47e56599")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                    for articleFromJson in articlesFromJson {
                        let article = Article()
                        if let title = articleFromJson["title"] as? String, let author = articleFromJson["author"] as? String, let desc = articleFromJson["description"] as? String, let url = articleFromJson["url"] as? String, let urlToImage = articleFromJson["urlToImage"] as? String {
                            
                            article.author = author
                            article.desc = desc
                            article.headline = title
                            article.url = url
                            article.imgUrl = urlToImage
                        }
                        
                        self.articlesArray.append(article)
                        
                    }
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
                
            } catch let error {
                print(error)
            }
            
        }
        
        task.resume()
        
    }
    
}





















