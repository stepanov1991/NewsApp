//
//  NewsManager.swift
//  NewsApp
//
//  Created by user on 06.02.2021.
//

import UIKit

protocol NewsManagerDelegate {
    func didUpdateNews(_ NewsManager: NewsManager, News: NewsModel)
    func didFailWithError(error: Error)
    
    
}

struct NewsManager {
    
    let newsUrl = "https://newsapi.org/v2/top-headlines?apiKey=0343443b19274dabb388688b381998ef&country=us"
    var delegate : NewsManagerDelegate?

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
    func parseJSON(_ newsData: Data) -> NewsModel? {
        let decoder = JSONDecoder()
        do{
            let decoderData = try decoder.decode(NewsData.self, from: newsData)
            
            let authorName = decoderData.articles[0].author
            let titleInformation = decoderData.articles[0].title
            let descriptionInformatiom = decoderData.articles[0].description
            let urlNews = decoderData.articles[0].url
            let urlToImage = decoderData.articles[0].urlToImage
            let sorceName = decoderData.articles[0].sorce.name
           
            
            let news = NewsModel(authorName: authorName, titleInformation: titleInformation, descriptionInformatiom: descriptionInformatiom, urlNews: urlNews, urlToImage: urlToImage, sorceName: sorceName)
            
            return news
        }
        catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
