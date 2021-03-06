//
//  NewsListingViewController.swift
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

protocol NewsListingDisplayLogic: class {
    func displayNewsDetails(viewModel: NewsListing.Route.ViewModel)
    func displayNewsListing(viewModel: NewsListing.Fetch.ViewModel)
    func displayError(error: NSError)
}

class NewsListingViewController: UIViewController, NewsListingDisplayLogic {
  var interactor: NewsListingBusinessLogic?
  var router: (NSObjectProtocol & NewsListingRoutingLogic & NewsListingDataPassing)?
    var displayArticles = [NewsListing.Fetch.ViewModel.DisplayArticle]()
    var selectedArticle: Article? = nil
    @IBOutlet weak var tableView: UITableView!
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController = self
    let interactor = NewsListingInteractor()
    let presenter = NewsListingPresenter()
    let router = NewsListingRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib(nibName: "NewsListingTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "NewsListingTableViewCell")

    fetchNewsListing()
  }
  
  func fetchNewsListing() {
    interactor?.fetchNewsListing(request: NewsListing.Fetch.Request())
  }

}

extension NewsListingViewController {
    
    func displayNewsListing(viewModel: NewsListing.Fetch.ViewModel) {
        self.displayArticles = viewModel.displayArticles
        self.tableView.reloadData()
    }
    
    func displayError(error: NSError) {
        
    }
    
    func displayNewsDetails(viewModel: NewsListing.Route.ViewModel) {
        router?.routeToNewsDetails()
    }
}

extension NewsListingViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListingTableViewCell", for: indexPath) as! NewsListingTableViewCell
        cell.configureCell(displayArticle: displayArticles[indexPath.row])
        return cell
    }

}

extension NewsListingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.handleNewsSelection(request: NewsListing.Route.Request(index: indexPath.row))
    }
}
