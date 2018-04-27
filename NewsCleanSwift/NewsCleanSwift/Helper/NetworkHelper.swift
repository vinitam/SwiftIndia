//
//  NetworkHelper.swift
//  NewsCleanSwift
//
//  Created by Vinita Miranda on 15/04/18.
//  Copyright © 2018 Vinita Miranda. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
let newsUrl: String = "https://newsapi.org/v2/top-headlines"

class NetworkHelper {
    class func fetchNewsListing(_ request: NewsListing.Fetch.Request, completionHandler: @escaping (_ articles: [Article]? , _ error: NSError? ) -> Void) {
        Alamofire.request(newsUrl, method: .get, parameters: ["country":"us", "apiKey": "cb18e2d529054ae49d58335a307d235e"], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            var articleList = [Article]()
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let articles = JSON(data)["articles"].arrayValue
                    for item in articles {
                        let article = Article(fromJson : JSON(item))
                        articleList.append(article)
                    }
                    completionHandler(articleList, nil)
                }
            case .failure(_):
                if let error = response.result.error as NSError? {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
