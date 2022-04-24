//
//  Location.swift
//  slider
//
//  Created by user213684 on 4/16/22.
//

import Foundation
import MapKit

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var type: String
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    //static let example = Location(id: UUID(), type: "resto",name: "Ottawa", description: "Where the PM lives", latitude: 45.42, longitude: -75.70)
    static let resto1 = Location(id: UUID(), type: "restaurant", name: "Resto 1", description: "Restaurant de Hull", latitude: 45.42378, longitude: -75.73201)
    static let resto2 = Location(id: UUID(), type: "restaurant", name: "Resto 2", description: "Restaurant d'Ottawa", latitude: 45.37436, longitude: -75.77303)
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
            lhs.id == rhs.id
    }
    
}
