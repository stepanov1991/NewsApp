//
//  NewsManager.swift
//  NewsApp
//
//  Created by user on 06.02.2021.
//

import UIKit

protocol NewsManagerDelegate {
    func didUpdateNews(_ NewsManager: NewsManager, News: [NewsModel])
    func didFailWithError(error: Error)
}

struct NewsManager {
    
    
    let newsUrl = "https://newsapi.org/v2/top-headlines?apiKey=0343443b19274dabb388688b381998ef&country=us&pageSize=100"
    var delegate : NewsManagerDelegate?
    
    
    func getNews() {
        
        performRequest(with: newsUrl)
        
    }
    
    
    func performRequest(with urlString: String) {
        if  let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, responce, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if  let news = self.parseJSON(safeData){
                        self.delegate?.didUpdateNews(self, News: news)
                    }
                }
            }
            
            task.resume()
        }
        
    }
    func parseJSON(_ newsData: Data) -> [NewsModel]? {
        let decoder = JSONDecoder()
        do{
            let decoderData = try decoder.decode(NewsData.self, from: newsData)
            
            
            let totalResults = decoderData.totalResults
            var newsArray = [NewsModel]()
           
            for result in 0...totalResults-1 {
               
                let authorName = decoderData.articles[result].author
                let titleInformation = decoderData.articles[result].title
                let descriptionInformatiom = decoderData.articles[result].description
                let urlNews = decoderData.articles[result].url
                let urlToImage = decoderData.articles[result].urlToImage
                let sourceName = decoderData.articles[result].source.name
                let publishedAt = decoderData.articles[result].publishedAt
                
                let news = NewsModel(authorName: authorName ?? "", titleInformation: titleInformation ?? "", descriptionInformatiom: descriptionInformatiom ?? "", urlNews: urlNews ?? "", urlToImage: urlToImage ?? "", sourceName: sourceName ?? "", totalResults: totalResults, publishedAt: publishedAt ?? "")
                newsArray.append(news)
            }
            let sortedNewsArray = newsArray.sorted { (first: NewsModel, second: NewsModel) -> Bool in
                first.publishedAt > second.publishedAt
            }
            
            return sortedNewsArray
        }
        catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
