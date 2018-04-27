//
//  Article.swift
//  NewsCleanSwift
//
//  Created by Vinita Miranda on 15/04/18.
//  Copyright © 2018 Vinita Miranda. All rights reserved.
//

import Foundation
import SwiftyJSON
class Article {
    var sourceName : String!
    var author : String!
    var title : String!
    var description : String!
    var url : String!
    var urlToImage : String!
    var publishedAt : String!

    init(fromJson json: JSON!){
        if json == JSON.null {
            return
        }
        
        let sourceJson = json["source"]
        sourceName = sourceJson["name"].stringValue
        

        author = json["author"].stringValue
        title = json["title"].stringValue
        description = json["description"].stringValue
        url = json["url"].stringValue
        urlToImage = json["urlToImage"].stringValue
        publishedAt = json["publishedAt"].stringValue
    }
}
