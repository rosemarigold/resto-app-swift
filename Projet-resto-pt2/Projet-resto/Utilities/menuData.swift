//
//  menuData.swift
//  Projet-resto
//
//  Created by user213684 on 3/27/22.
//

import Foundation

// tableau de type d'item
var menuData: [Menu] = loadJson("menuItem.json")

func loadJson<T: Decodable>(_ filename: String) -> T{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else{
        fatalError("\(filename) not found.")
    }
    
    do{
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename): \(error)");
    }
    
    do{
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename): \(error)")
    }

}
