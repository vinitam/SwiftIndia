//
//  NewsDetailsViewControllerTests.swift
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

class NewsDetailsViewControllerTests: XCTestCase {
  // MARK: Subject under test
  
  var sut: NewsDetailsViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp() {
    super.setUp()
    window = UIWindow()
    setupNewsDetailsViewController()
  }
  
  override func tearDown() {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupNewsDetailsViewController() {
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    sut = storyboard.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
  }
  
  func loadView() {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
    class NewsDetailsBusinessLogicSpy: NSObject, NewsDetailsBusinessLogic {
        // MARK: Method call expectations
        
        var updateViewOnLoadCalled = false
        
        // MARK: Spied methods
        
        func updateViewOnLoad(_ request: NewsDetails.OnLoad.Request) {
            updateViewOnLoadCalled = true
        }
        
    }
    
    class NewsDetailsRouterSpy: NSObject, NewsDetailsRoutingLogic, NewsDetailsDataPassing {
        var dataStore: NewsDetailsDataStore?
        
    }
    
    func testLoadViewShouldCallUpdateViewOnLoad() {
        // Given
        let newsDetailsBusinessLogicSpy = NewsDetailsBusinessLogicSpy()
        sut.interactor = newsDetailsBusinessLogicSpy
        
        // When
        loadView()
        
        // Then
        XCTAssert(newsDetailsBusinessLogicSpy.updateViewOnLoadCalled, "Update view on load is called on view load")
    }
    
  
    func testUpdateViewDidLoad() {
        // Given
        let router = NewsDetailsRouterSpy()
        sut.router = router
        sut.interactor = NewsDetailsBusinessLogicSpy()
        
        // When
        loadView()
        let urlString = "http://google.com/"
        let viewModel = NewsDetails.OnLoad.ViewModel(url : urlString)
        sut.displayViewOnLoad(viewModel: viewModel)

        // Then
        if let text = sut.webView.url?.absoluteString{
            XCTAssertEqual(text, urlString, "Display detailed url should be loaded in web view")
        }
    }

}
