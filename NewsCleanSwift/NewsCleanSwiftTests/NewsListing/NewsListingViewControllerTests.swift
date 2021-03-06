//
//  NewsListingViewControllerTests.swift
//  NewsCleanSwift
//
//  Created by Vinita Miranda on 22/04/18.
//  Copyright (c) 2018 Vinita Miranda. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import NewsCleanSwift
import XCTest

class NewsListingViewControllerTests: XCTestCase {
  // MARK: Subject under test
  
  var sut: NewsListingViewController!
  var window: UIWindow!

    // MARK: Test lifecycle
  
  override func setUp() {
    super.setUp()
    window = UIWindow()
    setupNewsListingViewController()
  }
  
  override func tearDown() {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupNewsListingViewController() {
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    sut = storyboard.instantiateViewController(withIdentifier: "NewsListingViewController") as! NewsListingViewController
  }
  
  func loadView() {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
    
    class NewsListingBusinessLogicSpy: NSObject, NewsListingBusinessLogic {
        // MARK: Method call expectations
        
        var fetchNewsListingCalled = false
        var handleNewsSelectionCalled = false

        // MARK: Spied methods
        
        func fetchNewsListing(request: NewsListing.Fetch.Request) {
            fetchNewsListingCalled = true
        }
        
        func handleNewsSelection(request: NewsListing.Route.Request) {
            handleNewsSelectionCalled = true
        }
        
    }
    
    class NewsListingRouterSpy: NSObject, NewsListingRoutingLogic, NewsListingDataPassing {
        var dataStore: NewsListingDataStore?
        
        // MARK: Method call expectations
        
        var routeToNewsDetailsCalled = false
        
        // MARK: Spied methods
        
        func routeToNewsDetails() {
            routeToNewsDetailsCalled = true
        }
    }
    
    func testViewDidLoadShouldCallFetchNewsListing() {
        // Given
        let newsListingBusinessLogicSpy = NewsListingBusinessLogicSpy()
        sut.interactor = newsListingBusinessLogicSpy
        
        // When
        loadView()
        
        // Then
        XCTAssert(newsListingBusinessLogicSpy.fetchNewsListingCalled, "Fetch news listing should be called on view did load")
    }

    func testFetchNewsListing() {
        // Given
        let router = NewsListingRouterSpy()
        sut.router = router
        sut.interactor = NewsListingBusinessLogicSpy()
        
        // When
        loadView()
        let displayArticles = [NewsListing.Fetch.ViewModel.DisplayArticle(sourceName: "Yahoo.com", displayAuthor: "Michelle Nichols", displayTitle: "Suspect in Ocala, Florida school shooting: 'I want to be put away'", displayDetailedUrl: "https://www.yahoo.com/news/suspect-ocala-florida-school-shooting-162346592.html", displayIconUrl: "")]
        let viewModel = NewsListing.Fetch.ViewModel(displayArticles: displayArticles)
        sut.displayNewsListing(viewModel: viewModel)
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell: NewsListingTableViewCell = sut.tableView.cellForRow(at: indexPath) as! NewsListingTableViewCell

        
        // Then
        XCTAssertEqual(cell.titleLabel.text, "Suspect in Ocala, Florida school shooting: 'I want to be put away'", "Display title should be populated for title field of news listing")
        XCTAssertEqual(cell.subtitleLabel.text, "Michelle Nichols", "Display author should be populated for subtitle field of news listing")
    }
    
    
}
