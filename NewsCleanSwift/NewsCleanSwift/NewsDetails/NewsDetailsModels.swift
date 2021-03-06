//
//  NewsDetailsModels.swift
//  NewsCleanSwift
//
//  Created by Vinita Miranda on 18/04/18.
//  Copyright (c) 2018 Vinita Miranda. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum NewsDetails {
    enum OnLoad {
        struct Request {
        }
        struct Response {
            var url: String!
        }
        struct ViewModel {
            var url: String!
        }
    }
}
