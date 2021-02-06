//
//  ViewController.swift
//  NewsApp
//
//  Created by user on 06.02.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var newsManager = NewsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        newsManager.delegate = self
        newsManager.getNews()
        // Do any additional setup after loading the view.
    }


}
//MARK: - NewsManagerDelegate
extension ViewController : NewsManagerDelegate {
    func didUpdateNews(_ NewsManager: NewsManager, News: NewsModel) {
        DispatchQueue.main.async {
            print(News.authorName)
            print(News.titleInformation)
            print(News.descriptionInformatiom)
            print(News.urlNews)
            print(News.urlToImage)
            print(News.sourceName)        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

