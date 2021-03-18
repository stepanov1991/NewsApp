//
//  DetailViewController.swift
//  NewsApp
//
//  Created by user on 11.02.2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newsUrl = URL(string: url)
        let newsRequest = URLRequest(url: newsUrl!)
        webView.load(newsRequest)

    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    
}
