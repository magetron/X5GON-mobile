//
//  Chunk.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 25/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

class WikiChunk {
    let entities: [WikiEntity]
    let length: Double
    let start: Double
    let text: String
    
    init (entities: [WikiEntity], length: Double, start: Double, text:String) {
        self.entities = entities
        self.length = length
        self.start = start
        self.text = text
    }
}
