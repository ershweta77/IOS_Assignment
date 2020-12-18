//
//  Book.swift
//  BooksApp
//
//  Created by Apple on 18/12/20.
//  Copyright © 2020 Assignment. All rights reserved.
//

import Foundation


struct Response : Codable
{
    struct Results : Codable
    {
        struct Lists : Codable {
            var books : [Book]
       }
        var lists : [Lists]
    }
    var results : Results
}

struct Book : Codable {
    var contributor: String!
    var publisher: String!
    var description: String!
    var title: String!
    var author: String!
}
