//
//  Memories.swift
//  weatherBot
//
//  Created by Alexander B on 09/12/2018.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
//

import Foundation

protocol Memory {
    
}
struct Loan: Memory {
    var text = String()
}

struct Meetup: Memory {
    var text = String()
}

var memories = [Loan(text: "Remind your friend about that something... ")] {
    didSet {
        print(memories.count)
        indexPaths.append(IndexPath(item: memories.count, section: 0))
    }
}
var indexPaths = [IndexPath]()


