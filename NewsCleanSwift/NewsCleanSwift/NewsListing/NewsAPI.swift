//
//  NewsAPI.swift
//  NewsCleanSwift
//
//  Created by Vinita Miranda on 23/04/18.
//  Copyright © 2018 Vinita Miranda. All rights reserved.
//


import Foundation

class NewsAPI: NewsListingProtocol {
    
    func fetchNewsListing(_ request: NewsListing.Fetch.Request, completionHandler: @escaping (_ articles: [Article]?, _ error: NSError?) -> Void) {
        NetworkHelper.fetchNewsListing(request) { (articles, error) in
            completionHandler(articles, error)
        }
    }

}

