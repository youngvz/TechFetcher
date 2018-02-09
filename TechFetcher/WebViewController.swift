//
//  WebviewViewController.swift
//  TechFetcher
//
//  Created by Jason Park on 2/8/18.
//  Copyright © 2018 Jason Park. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    
    var urlString: String?
    
    lazy var webView: WKWebView = {
        [weak self] in
        let wv = WKWebView()
        wv.translatesAutoresizingMaskIntoConstraints = false
        return wv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        setupWebView()
        
        view.addSubview(webView)
        
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        }
    }
    
    func setupWebView(){
        
        guard let url = urlString else { return }
        guard let webViewURL = URL(string: url) else { return }
        
        let request = URLRequest(url: webViewURL)
        
        webView.load(request)
    }
}
