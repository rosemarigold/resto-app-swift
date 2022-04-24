//
//  menu.swift
//  Projet-resto
//
//  Created by user213684 on 3/27/22.
//

import Foundation

struct Menu: Codable, Identifiable{
    var id: String
    var name: String
    var type: String
    var isCombo: Bool
    var isSelected: Bool
    var priceItem: Float
    var priceCombo: Float
}
    
