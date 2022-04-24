//
//  TroisiemeVue.swift
//  Projet-resto
//
//  Created by user213684 on 3/27/22.
//
// Source1: https://www.youtube.com/watch?v=BlTFA_Er70A&ab_channel=CodeWithChris
// Source2: https://stackoverflow.com/questions/56487323/make-a-vstack-fill-the-width-of-the-screen-in-swiftui
// Source3: https://www.youtube.com/watch?v=NPCTUcW8SNQ&ab_channel=iOSAcademy

import MapKit
import SwiftUI

struct TroisiemeVue: View {
    // pour le bouton retour
    @Environment(\.dismiss) private var dismiss
    
    // pour acceder aux items du menu
    //@ObservedObject var menuStore: MenuStore;
    let menuStore: MenuStore;
    
    // variable to save order
    @Environment(\.managedObjectContext) var moc
    
    // for the map region
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.425, longitude: -75.739), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.date),
        SortDescriptor(\.total)
    ]) var historique: FetchedResults<Commande>
    
    // to present an alert
    @State private var presentAlert = false
    
    /// <#Description#>
    var body: some View {
        
        // numero de commande a afficher
        var numeroDeLaCommande = historique.count + 1;
        
        ZStack{
            //background color
            Color.orange
                .edgesIgnoringSafeArea(.all)
                .overlay(Rectangle()
                    .fill(.white)
                    .frame(width: 400, height: 760)
                    .offset(y:40))
            // Bouton Retour
            VStack{
                // TabView
                TabView{
                    // FACTURE
                    VStack{
                        VStack{
                            // #1 titre facture
                            VStack{
                                Text("À la bonne patate")
                                    .font(.system(size: 38))
                                    .bold()
                                    .lineLimit(nil)
                                // current time view
                                //dateView()
                                Text(dateOfTheDay())
                            }
                            // #2 facture contenu
                            VStack{
                                // width wider
                                HStack {
                                    Spacer()
                                }
                                // afficher les items seletionees
                                VStack(alignment: .leading){
                                    Text(" ")
                                    Text(" ")
                                    if( TotalCommande(menuStore: menuStore) == 0.00){
                                        HStack(alignment: .center){
                                            Text("SVP sélectionner un item.")
                                        }.frame(width: 300, height: 200)
                                    }
                                    ForEach(menuStore.menu){ menu in HStack{
                                        if(menu.isSelected){
                                            if(menu.isCombo == false){
                                                Text("-- " + menu.name + "  [Item] ... $" + String(menu.priceItem))
                                                    .padding(.bottom, 8)
                                            }
                                            else if(menu.isCombo == true){
                                                Text("-- " + menu.name + "  [Combo] ... $" + String(menu.priceCombo)).padding(.bottom, 8)
                                            }
                                        }
                                    }
                                    }
                                }.frame(width: 300, height: 390, alignment: .topLeading)
                                
                            }.padding(5)
                            
                            // #3 facture total
                            VStack(alignment: .trailing){
                                
                                Text("Total (avant taxes): $ " + String(format: "%.2f", TotalCommande(menuStore: menuStore)))
                                Text("Taxes: $ " + String(format: "%.2f", TotalCommande(menuStore: menuStore) * 0.15))
                                Text("Montant total: $ " + String(format: "%.2f", (TotalCommande(menuStore: menuStore) * 0.15) + TotalCommande(menuStore: menuStore)))
                            }
                        }
                        .padding(15)
                    }
                    .border(/*@START_MENU_TOKEN@*/Color.orange/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/4/*@END_MENU_TOKEN@*/)
                    .padding(10)
                    .frame(width: 350, height: 610)
                    .tabItem{
                        Image(systemName: "creditcard.fill").foregroundColor(.orange)
                        Text("Facture")
                            .foregroundColor(.orange)
                            .font(.system(size: 100))
                            .tag(1)
                    }
                    // TabView #2
                    VStack{
                        // display map view
                        map()
                    }.tabItem{
                        Image(systemName: "map.fill").foregroundColor(.orange)
                        Text("Livraison")
                            .foregroundColor(.orange)
                            .font(.system(size: 100))
                            .tag(2)
                    }
                    // TabView #3
                    VStack{
                        Spacer()
                        // Ajouter une commande
                        Button {
                            //let livre = Livre(context: moc)
                            let commande = Commande(context: moc)
                            
                            // instance of date formatter
                            let dateFormatter = DateFormatter()
                            
                            // format of our date
                            dateFormatter.dateFormat = "dd MMMM yyyy"
                            
                            // put the in french
                            dateFormatter.locale = Locale(identifier: "fr")
                            
                            // creer la commande
                            commande.id = UUID()
                            commande.date = dateFormatter.date(from:dateOfTheDay())
                            commande.total = (TotalCommande(menuStore: menuStore) + (TotalCommande(menuStore: menuStore) * 0.15))
                            commande.numero = String(numeroDeLaCommande)
                            
                            // save the new order
                            try? moc.save()
                            
                            // when click, present alert
                            presentAlert = true;
                        } label: {
                            Rectangle()
                                .fill(.green)
                                .frame(width: 340, height: 90)
                                .cornerRadius(15)
                                .overlay(
                                    Text("Commander!!")
                                        .foregroundColor(.black)
                                        .font(.system(size: 35))
                                ).offset(y:-240)
                        } //confirmation alert
                        .alert(isPresented: $presentAlert, content: {
                            Alert(title: Text("C'est envoyé."), message: Text("La commande a été créée avec succès."), dismissButton: .default(Text("Retour")){  dismiss() })
                        })
                        .padding()
                        
                        
                    }.tabItem{
                        Image(systemName: "dollarsign.square.fill")
                        Text("Paiement").tag(3)
                    }
                }.frame(width: 400, height: 681)
            }
        }
        // bouton retour
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // mettre le bouton retour a gauche
            ToolbarItem(placement: .navigationBarLeading){
                Button { dismiss() } label: {
                    Capsule()
                        .fill(.green)
                        .frame(width: 120, height: 40)
                        .overlay(
                            HStack{
                                Image(systemName: "arrow.left").foregroundColor(.black)
                                Text("RETOUR").foregroundColor(.black)
                            }
                        )
                }
            }
        }
    }
}
struct TroisiemeVue_Previews: PreviewProvider {
    static var previews: some View {
        // get the menuStore object from DeuxiemeVue
        TroisiemeVue(menuStore: MenuStore())
    }
}
// pour calculer le total de la facture
func TotalCommande(menuStore: MenuStore) -> Double{
    
    //let menuStore: MenuStore
    
    var total : Double = 0.0
    
    for menu in menuStore.menu{
        if(menu.isSelected){
            if(menu.isCombo == false){
                total += Double(menu.priceItem)
            }
            else if(menu.isCombo == true){
                total += Double(menu.priceCombo)
            }
        }
    }
    return total;
}

// pour afficher la date
func dateOfTheDay() -> String {
    
    // instance of Date
    let dateToday = Date()
    
    // instance of date formatter
    let dateFormatter = DateFormatter()
    
    // format of our date
    dateFormatter.dateFormat = "dd MMMM yyyy"
    
    // put the in french
    dateFormatter.locale = Locale(identifier: "fr")
    
    // return date of the day
    return dateFormatter.string(from: dateToday)
}
