//
//  ContentView.swift
//  slider
//
//  Created by user213684 on 4/7/22.
import MapKit
import SwiftUI

//
/*var locations = [
    Location(id: UUID(), type: "restaurant", name: "Resto 1", description: "Restaurant de Hull", latitude: 45.42378, longitude: -75.73201),
    Location(id: UUID(), type: "restaurant", name: "Resto 2", description: "Restaurant d'Ottawa", latitude: 45.37436, longitude: -75.77303)
]*/

struct map: View {
    
    // tous les locations
    @State private var locations = [Location.resto1, Location.resto2]

    // define start region
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.422, longitude: -75.693), span: MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4))
    
    // form variables
    @State var adresse = ""
    @State var ville = ""
    
    // pour disable ou non le bouton soumettre
    @State private var disabled = true
    
    // function to find the address
    func chercherAdresse() -> Void {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "\(adresse), \(ville)"
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
           let newLocation = Location(id: UUID(), type: "client", name: "Livraison", description: "Adresse de livraison du client", latitude: response.mapItems[0].placemark.coordinate.latitude, longitude: response.mapItems[0].placemark.coordinate.longitude)
            
            locations.append(newLocation)
        }
    }
    // function that verifies if the Textfield are empty or not
    func isTextEmpty() -> Void {
        if(!adresse.isEmpty && !ville.isEmpty){
            disabled = false;
        }
        else if(adresse.isEmpty || ville.isEmpty){
            disabled = true;
        }
    }
    
    var body: some View {
        VStack{
            // display map
            Map(coordinateRegion: $region, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        // if the location is a restaurant
                        if(location.type == "restaurant"){
                            // SF image
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                        }
                        // if the location is the client's address
                            else if(location.type == "client"){
                                // SF image
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .foregroundColor(.blue)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(Circle())
                            }
                            // nom de la localisation
                            Text(location.name)
                                .fixedSize()
                    }
                }
            }.overlay(
                VStack{
                    // adresse & ville textfields
                    VStack(alignment: .center, spacing: 2){
                        TextField("Adresse", text: $adresse)
                            .padding(.leading, 10)
                            .frame(height:50)
                            .background(Color.white)
                        TextField("Ville", text: $ville)
                            .padding(.leading, 10)
                            .frame(height:50)
                            .background(Color.white)
                        
                    }.frame(width:360)
                    .font(.system(size: 25))
             
                    Button{
                        // chercher l'adresse
                        chercherAdresse()
                    }
                label: {
                    Capsule()
                        .fill((ville.isEmpty || adresse.isEmpty) ? Color.gray: Color.purple)
                        .frame(width: 150, height: 40)
                        .overlay(
                            HStack{
                                Text("Soumettre")
                                Image(systemName: "arrow.turn.down.left")
                            }.foregroundColor(Color.white)
                        )//.offset(x:90)
                        .offset(x:80, y:-7)
                }.disabled((ville.isEmpty || adresse.isEmpty) ? disabled: !disabled)
                }.offset(y:-230)
            )
        }
    }
}
struct map_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
