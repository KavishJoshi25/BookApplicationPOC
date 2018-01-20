//
//  RequestResponceHandler.swift
//  BookApplicationPOC
//
//  Created by Kavish joshi on 15/01/18.
//  Copyright © 2018 Kavish joshi. All rights reserved.
//

import Foundation
import Alamofire

typealias ResponseWithDic = ([BooksEntity], NSError?,String?) -> Void
//typealias searchResponseWithDic = (AnyObject, NSError?,String?) -> Void

let maxResultCount = 40

class RequestResponceHandler: NSObject {
    
    // MARK: Shared Instance
    static let shared = RequestResponceHandler()
    
    var getBooksRequestInstance : Request? = nil
    
    //MARK:getMostPopularMovies
    func getAllBooks(startIndex:Int,onCompletion: @escaping ResponseWithDic)  {
        
        if (getBooksRequestInstance != nil) {
            getBooksRequestInstance?.cancel()
        }
        getBooksRequestInstance = Alamofire.request(AppBaseUrl.allBooks + "startIndex=\(startIndex)&maxResults=\(maxResultCount)").responseJSON(completionHandler: { (responce) in
            
            self.getBooksRequestInstance = nil
            
            if let json = responce.result.value {
                
                let movieObj:Dictionary = json as! Dictionary<String,Any>
                
                let resultArr = movieObj["items"] as! NSArray
                
                var booksArrayReturn:[BooksEntity] = [BooksEntity]()
                
                for item in resultArr{
                    
                    let booksEntityObj:BooksEntity = BooksEntity()
                    
                    let dicOne = item as! NSDictionary
                    
                    booksEntityObj.bookKind = dicOne["kind"] as? String ?? ""
                    booksEntityObj.id = dicOne["id"] as? String ?? ""
                    booksEntityObj.etag = dicOne["etag"] as? String ?? ""
                    booksEntityObj.selfLink = dicOne["selfLink"] as? String ?? ""
                    
                    let bookVolumeInfo = dicOne["volumeInfo"] as! NSDictionary
                    
                    //volumeInfo
                    let bookInfo:volumeInfoEntity = volumeInfoEntity()
                    
                    bookInfo.title = bookVolumeInfo["title"] as? String ?? ""
                    bookInfo.subtitle = bookVolumeInfo["subtitle"] as? String ?? ""
                    
                    if bookVolumeInfo["authors"] as? NSArray != nil{
                        bookInfo.authors = bookVolumeInfo["authors"] as? NSArray as! [String]
                    }
                    
                    bookInfo.publisher = bookVolumeInfo["publisher"] as? String ?? ""
                    bookInfo.publishedDate = bookVolumeInfo["publishedDate"] as? String ?? ""
                    bookInfo.bookDescription = bookVolumeInfo["description"] as? String ?? ""
                    bookInfo.pageCount = bookVolumeInfo["pageCount"] as? Int ?? 0
                    bookInfo.printType = bookVolumeInfo["printType"] as? String ?? ""

                    bookInfo.averageRating = bookVolumeInfo["averageRating"] as? Int ?? 0
                    bookInfo.ratingsCount = bookVolumeInfo["ratingsCount"] as? Int ?? 0
                    
                    bookInfo.imageLinks = (bookVolumeInfo["imageLinks"] as! NSDictionary) as! [String : String]
                    
                    bookInfo.language = bookVolumeInfo["language"]  as? String ?? ""
                    
                     bookInfo.previewLink = bookVolumeInfo["previewLink"] as? String ?? ""
                    
                    bookInfo.infoLink = bookVolumeInfo["infoLink"]  as? String ?? ""
                    
                    bookInfo.canonicalVolumeLink = bookVolumeInfo["canonicalVolumeLink"]  as? String ?? ""

                    booksEntityObj.volumeInfo = [bookInfo]
                    
                    
                    if dicOne["searchInfo"] as? NSDictionary != nil{
                        //searchinfo
                        booksEntityObj.searchInfo = (dicOne["searchInfo"] as! NSDictionary) as? [String : String] ?? [:]
                    }
                    
                    
                    booksArrayReturn.append(booksEntityObj)
                }
                onCompletion(booksArrayReturn , nil, "")
            }else{
                onCompletion(([] as NSMutableArray) as! [BooksEntity], responce.error! as NSError, "")
            }
            
        })
    }
    
    //---------End of getMostPopularMovies

}

//
//    {
//    "kind": "books#volume",
//    "id": "P8VWKHFmlVQC",
//    "etag": "nO12vtwQWEg",
//    "selfLink": "https://www.googleapis.com/books/v1/volumes/P8VWKHFmlVQC",
//    "volumeInfo": {
//    "title": "Power",
//    "subtitle": "A Philosophical Analysis, Second Edition",
//    "authors": [
//    "Peter Morriss"
//    ],
//    "publisher": "Manchester University Press",
//    "publishedDate": "2002",
//    "description": "This study of power in a modern context asks why there is a concept of power at all. It compares different powers and discusses the literature on power and ability, and the relationship between power and freedom. Understanding of power is presented as vital for a radical critique of society.",
//    "industryIdentifiers": [
//    {
//    "type": "ISBN_10",
//    "identifier": "0719059968"
//    },
//    {
//    "type": "ISBN_13",
//    "identifier": "9780719059964"
//    }
//    ],
//    "readingModes": {
//    "text": false,
//    "image": true
//    },
//    "pageCount": 277,
//    "printType": "BOOK",
//    "categories": [
//    "Philosophy"
//    ],
//    "averageRating": 4,
//    "ratingsCount": 1,
//    "maturityRating": "NOT_MATURE",
//    "allowAnonLogging": false,
//    "contentVersion": "0.0.1.0.preview.1",
//    "imageLinks": {
//    "smallThumbnail": "http://books.google.com/books/content?id=P8VWKHFmlVQC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
//    "thumbnail": "http://books.google.com/books/content?id=P8VWKHFmlVQC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
//    },
//    "language": "en",
//    "previewLink": "http://books.google.co.in/books?id=P8VWKHFmlVQC&printsec=frontcover&dq=a&hl=&cd=81&source=gbs_api",
//    "infoLink": "http://books.google.co.in/books?id=P8VWKHFmlVQC&dq=a&hl=&source=gbs_api",
//    "canonicalVolumeLink": "https://books.google.com/books/about/Power.html?hl=&id=P8VWKHFmlVQC"
//    },
//    "saleInfo": {
//    "country": "IN",
//    "saleability": "NOT_FOR_SALE",
//    "isEbook": false
//    },
//    "accessInfo": {
//    "country": "IN",
//    "viewability": "PARTIAL",
//    "embeddable": true,
//    "publicDomain": false,
//    "textToSpeechPermission": "ALLOWED",
//    "epub": {
//    "isAvailable": false
//    },
//    "pdf": {
//    "isAvailable": false
//    },
//    "webReaderLink": "http://play.google.com/books/reader?id=P8VWKHFmlVQC&hl=&printsec=frontcover&source=gbs_api",
//    "accessViewStatus": "SAMPLE",
//    "quoteSharingAllowed": false
//    },

//    },
//
//    
//}

