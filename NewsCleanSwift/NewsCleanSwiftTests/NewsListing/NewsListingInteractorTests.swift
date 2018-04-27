//
//  NewsListingInteractorTests.swift
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

class NewsListingInteractorTests: XCTestCase {
  // MARK: Subject under test
  
  var sut: NewsListingInteractor!
  
  // MARK: Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupNewsListingInteractor()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupNewsListingInteractor() {
    sut = NewsListingInteractor()
  }
  
    class NewsListingWorkerSpy: NewsListingWorker {
        var fetchNewsListingCalled = false
        var success = false

        override func fetchNewsListing(_ request: NewsListing.Fetch.Request, completionHandler: @escaping (_ articles: [Article]?, _ error: NSError?) -> Void) {
            fetchNewsListingCalled = true
            if(success) {
                completionHandler(Mock.News.articles, nil)
            }
            else{
                completionHandler(nil, NSError())
            }
        }
    }
    
    class NewsListingPresentationLogicSpy: NewsListingPresentationLogic {
        var presentNewsListingCalled = false
        var presentErrorCalled = false
        var presentNewsDetailsCalled = false

        func presentNewsListing(response: NewsListing.Fetch.Response) {
            presentNewsListingCalled = true
        }
        
        func presentError(error: NSError) {
            presentErrorCalled = true
        }
        
        func presentNewsDetails(response: NewsListing.Route.Response) {
            presentNewsDetailsCalled = true
        }
    }
    
    func testFetchNewsListingShouldAskPresenterToPresentSuccess() {
        // Given
        let newsListingPresentationLogicSpy = NewsListingPresentationLogicSpy()
        sut.presenter = newsListingPresentationLogicSpy
        let newsListingWorkerSpy = NewsListingWorkerSpy(newsListingStore: NewsAPI())
        newsListingWorkerSpy.success = true
        sut.worker = newsListingWorkerSpy
        
        // When
        let request = NewsListing.Fetch.Request()
        sut.fetchNewsListing(request: request)
        
        // Then
        XCTAssert(newsListingPresentationLogicSpy.presentNewsListingCalled, "Fetch news listing should ask presenter to present result on success")
    }
    
    
    func testFetchNewsListingErrorShouldAskPresenterToPresentError() {
        // Given
        let newsListingPresentationLogicSpy = NewsListingPresentationLogicSpy()
        sut.presenter = newsListingPresentationLogicSpy
        let newsListingWorkerSpy = NewsListingWorkerSpy(newsListingStore: NewsAPI())
        sut.worker = newsListingWorkerSpy
        
        // When
        let request = NewsListing.Fetch.Request()
        sut.fetchNewsListing(request: request)
        
        // Then
        XCTAssert(newsListingPresentationLogicSpy.presentErrorCalled, "Fetch news listing error should ask presenter to present the error")
    }
}
