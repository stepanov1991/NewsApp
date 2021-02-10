//
//  ViewController.swift
//  NewsApp
//
//  Created by user on 06.02.2021.
//

import UIKit
import Alamofire
import AlamofireImage

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var newsManager = NewsManager()
    
    var totalResults = 0
    var newsArray : [NewsModel] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsManager.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.cellIdentifier , bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
       
        newsManager.getNews()
        
        
        
        // Do any additional setup after loading the view.
    }


}
//MARK: - NewsManagerDelegate
extension NewsViewController : NewsManagerDelegate {
    func didUpdateNews(_ NewsManager: NewsManager, News: [NewsModel]) {
        DispatchQueue.main.async {
            self.newsArray.append(contentsOf: News)
            self.tableView.reloadData()
            let indexPath = IndexPath(row: self.newsArray.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
//MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
        
      
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! NewsCell
        cell.authorlabel.text = news.authorName
        cell.descriptionLabel.text = news.descriptionInformatiom
        cell.sourceLabel.text = news.sourceName
        cell.titleLabel.text = news.titleInformation
        
        AF.request(news.urlToImage).responseImage { response in
            debugPrint(response)

            print(response.request)
            print(response.response)
            debugPrint(response.result)

            if case .success(let image) = response.result {
                DispatchQueue.main.async {
                    cell.newsImage.image = image
                }
              
            }
        }
        
        return cell
        
    }


}

