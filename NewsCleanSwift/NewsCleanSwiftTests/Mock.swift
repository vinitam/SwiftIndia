//
//  Mock.swift
//  NewsCleanSwiftTests
//
//  Created by Vinita Miranda on 23/04/18.
//  Copyright © 2018 Vinita Miranda. All rights reserved.
//

@testable import NewsCleanSwift

import UIKit
import Foundation
import XCTest
import SwiftyJSON

enum Mock {
    struct News{
        static let articles = getArticles()
    }
}

class NewsCleanSwiftClass: NSObject {
    
}

private func fetchJsonData(fileName: String) -> JSON? {
    do {
        let testBundle = Bundle(for: NewsCleanSwiftClass.self)
        let dataString = try String(contentsOfFile: testBundle.path(forResource: fileName, ofType: "")!)
        let data = dataString.data(using: .utf8)
        do {
            return try JSON(data: data!)
        } catch let error as NSError {
            return nil
        }
    } catch {
        return nil
    }
}

private func getArticles() -> [Article] {
    let jsonData = fetchJsonData(fileName: "articles.json")!
    var articles = [Article]()
    let jsonArray = jsonData["articles"].array
    for item in jsonArray! {
        let article = Article(fromJson: item)
        articles.append(article)
    }
    return articles
}
