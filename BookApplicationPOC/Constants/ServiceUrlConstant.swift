//
//  ServiceUrlConstant.swift
//  BookApplicationPOC
//
//  Created by Kavish joshi on 15/01/18.
//  Copyright © 2018 Kavish joshi. All rights reserved.
//

import Foundation
import Foundation

struct AppBaseUrl {
    
    private static let baseUrl = "https://www.googleapis.com/books/v1/volumes"
    
    //allBooks
    static var allBooks : String {
        return baseUrl + "?q=a&"
    }
    
}
