//
//  menuStore.swift
//  Projet-resto
//
//  Created by user213684 on 3/27/22.
//

import Foundation

class MenuStore: ObservableObject{

    // publie un tableau d'item du menu
    @Published var menu: [Menu]
    
    // constructeur
    init(_ menu: [Menu] = []) {
        self.menu = menu
    }
}
