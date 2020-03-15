//
//  Chunk.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 25/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation

class Wiki {
    /// list of wikiChunks
    let chunks : [WikiChunk]
    
    /// Performe `Wiki` initialization
    init (chunks: [WikiChunk]) {
        self.chunks = chunks
    }
}
