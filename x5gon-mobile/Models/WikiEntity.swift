//
//  File.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 25/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

class WikiEntity {
    /// Id for wiki entity
    let id: String
    /// Title for wiki entity
    let title: String
    /// url for wiki entity
    let url: URL

    /// Performe `WikiEntity` initialization
    init(id: String, title: String, url: URL) {
        self.id = id
        self.title = title
        self.url = url
    }
}
