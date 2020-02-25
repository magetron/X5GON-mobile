//
//  File.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 25/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

class WikiEntity {
    let id: String
    let title: String
    let url: URL
    
    init (id: String, title: String, url: URL) {
        self.id = id
        self.title = title
        self.url = url
    }
}
