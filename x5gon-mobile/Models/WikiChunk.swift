//
//  Chunk.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 25/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

class WikiChunk {
    /// this is a list of wiki entities
    let entities: [WikiEntity]
    // length of wikichunk which is a **Double**
    let length: Double
    /// start from Type: **Double**
    let start: Double
    ///  WikiChunk text
    let text: String

    /// Performe `WikiChunk` initialization
    init(entities: [WikiEntity], length: Double, start: Double, text: String) {
        self.entities = entities
        self.length = length
        self.start = start
        self.text = text
    }
}
