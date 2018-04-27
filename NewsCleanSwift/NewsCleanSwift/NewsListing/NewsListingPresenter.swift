//
//  NewsListingPresenter.swift
//  NewsCleanSwift
//
//  Created by Vinita Miranda on 15/04/18.
//  Copyright (c) 2018 Vinita Miranda. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NewsListingPresentationLogic {
    func presentNewsDetails(response: NewsListing.Route.Response)
    func presentNewsListing(response: NewsListing.Fetch.Response)
    func presentError(error: NSError)
}

class NewsListingPresenter: NewsListingPresentationLogic {
    weak var viewController: NewsListingDisplayLogic?
  
    func presentNewsListing(response: NewsListing.Fetch.Response) {
        var displayArticles = [NewsListing.Fetch.ViewModel.DisplayArticle]()
        for article in response.articles {
            var displayArticle = NewsListing.Fetch.ViewModel.DisplayArticle()
            displayArticle.sourceName = article.sourceName
            displayArticle.displayAuthor = article.author
            displayArticle.displayTitle = article.title
            displayArticle.displayDetailedUrl = article.url
            displayArticle.displayIconUrl = article.urlToImage
            displayArticles.append(displayArticle)
        }
        viewController?.displayNewsListing(viewModel: NewsListing.Fetch.ViewModel(displayArticles: displayArticles))
    }
    
    func presentError(error: NSError) {
        viewController?.displayError(error: error)
    }
    
    func presentNewsDetails(response: NewsListing.Route.Response) {
        viewController?.displayNewsDetails(viewModel: NewsListing.Route.ViewModel())
    }
}
