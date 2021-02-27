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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var newsManager = NewsManager()
    var totalResults = 0
    var newsArray : [NewsModel] = []
    var filterNews : [NewsModel]!
    var country = "us"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsManager.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        tableView.register(UINib(nibName: K.cellIdentifier , bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        filterNews = newsArray
        
        newsManager.getNews(country: country)
        
       
        
        
        
    }
    
    
    @IBAction func filterPressed(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: K.filterViewIdentifier) as! FilterViewController
        navigationController?.pushViewController(vc, animated: true)
        vc.newsVievController = self
    }
    
    func getCountry(country : String )  {
     
        DispatchQueue.main.async {
          
            self.newsArray.removeAll()
            self.newsManager.getNews(country: country)
            self.tableView.reloadData()
        }
     
      
        
        
        
    }
    
    
    
    
}
//MARK: - NewsManagerDelegate
extension NewsViewController : NewsManagerDelegate {
    
    func didUpdateNews(_ NewsManager: NewsManager, News: [NewsModel]) {
        DispatchQueue.main.async {
            self.newsArray.append(contentsOf: News)
            self.filterNews = self.newsArray
            self.tableView.reloadData()
            let indexPath = IndexPath(row: self.newsArray.count - 1, section: 0)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
//MARK: - UITableViewDataSource, UITableViewDelegate
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterNews.count
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = filterNews[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! NewsCell
        cell.authorlabel.text = news.authorName
        cell.descriptionLabel.text = news.descriptionInformatiom
        cell.sourceLabel.text = news.sourceName
        cell.titleLabel.text = news.titleInformation
        
        AF.request(news.urlToImage).responseImage { response in
//            debugPrint(response)
//
//            print(response.request)
//            print(response.response)
//            debugPrint(response.result)
//
            if case .success(let image) = response.result {
                DispatchQueue.main.async {
                    cell.newsImage.image = image
                }
                
            }
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsArray[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: K.detailViewIdentifier) as! DetailViewController
        vc.url = news.urlNews
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
}
//MARK: - UISearchBarDelegate
extension NewsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterNews = []
        if searchText == "" {
            filterNews = newsArray
        }
        else {
            for news in newsArray {
                if news.authorName.lowercased().contains(searchText.lowercased()) || news.descriptionInformatiom.lowercased().contains(searchText.lowercased()) || news.sourceName.lowercased().contains(searchText.lowercased()) || news.titleInformation.lowercased().contains(searchText.lowercased()) {
                    filterNews.append(news)
                }
            }
            
        }
        self.tableView.reloadData()
    }
}

