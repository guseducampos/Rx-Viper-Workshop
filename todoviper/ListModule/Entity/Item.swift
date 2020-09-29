//
//  Item.swift
//  todoviper
//
//  Created by Gustavo Campos on 29/9/20.
//

import Foundation

struct Item: Codable, Hashable {
    var id = UUID()
    let name: String
}
