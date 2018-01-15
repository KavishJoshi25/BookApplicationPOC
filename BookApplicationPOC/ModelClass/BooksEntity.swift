//
//  BooksEntity.swift
//  BookApplicationPOC
//
//  Created by Kavish joshi on 15/01/18.
//  Copyright © 2018 Kavish joshi. All rights reserved.
//

import Foundation

class BooksEntity: NSObject {
    
    var bookKind = ""
    var id = ""
    var etag = ""
    var selfLink = ""
    
    var volumeInfo = [volumeInfoEntity]()
    
    var authors  = [String]()
    
    var publisher = ""
    var publishedDate = ""
    var pageCount = ""
    var printType = ""
    
    var averageRating = ""
    var ratingsCount = ""
    var maturityRating = ""
    var allowAnonLogging = ""
    
    var searchInfo = [String:String]()
    
}


