//
//  Historique.swift
//  Projet-resto
//
//  Created by user213684 on 4/10/22.
//

import SwiftUI

struct Historique: View {
    //
    @Environment(\.managedObjectContext) var moc
    
    // pour le bouton payer
    @Environment(\.dismiss) private var dismiss
    
    // #1 @FetchRequest: propriete wrapper qui va fetch les datas
    // et assure que les datas et le ui son in sync
    // #2 sortDescriptor: Comment presenter les donnees
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.date),
        SortDescriptor(\.total)
    ]) var historique: FetchedResults<Commande>
    
    // pour supprimer le coreData au besoin
    /*func supprimerCommande() {
     //moc.delete(historique[0])
     //moc.delete(historique[1])
     //moc.delete(historique[2])
     //moc.delete(historique[3])
     //moc.delete(historique[4])
     //moc.delete(historique[5])
     
     try? moc.save()
     }*/
    
    var body: some View {
        ZStack{
            //background color
            Color.purple.edgesIgnoringSafeArea(.all);
            
            VStack{
                // title
                HStack{
                    Text("Historique de commandes")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()
                    Spacer()
                    Button { dismiss() } label: {
                        HStack{
                            Circle().overlay(
                                Image(systemName: "xmark")
                                    .font(.system(size: 30))
                                    .foregroundColor(.purple)
                            )
                            .frame(width: 50, height: 45)
                            .foregroundColor(.orange)
                        }
                    }.padding()
                }
                // affichee le sous titre s'il y a des commandes
                if(historique.count > 0){
                    Text("Nb de commandes: \(historique.count)")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
            }.offset(y:-300)
            
            // pour supprimer le coreData au besoin
            //.onAppear(perform: supprimerCommande)
            
            // afficher les commandes
            VStack(alignment: .leading){
                // when the list gets long, scrollView is there to save the day
                ScrollView {
                    if(historique.count == 0){
                        Text("Aucune commande passée")
                            .offset(y:160)
                            .frame(width: 330, height: 250, alignment: .center)
                    }
                    ForEach(historique) { hist in
                        HStack{
                            // afficher le numero de la commande
                            Text("#" + hist.numero!)
                                .font(.system(size: 30))
                                .padding();
                            
                            VStack{
                                // afficher la date de chaque commande
                                Text(dateToString(datevar: hist.date!))
                                // afficher le total de chaque commande
                                Text("Total: $" + String(format: "%.2f", hist.total))
                            }
                        }
                        .frame(width: 330, height: 100, alignment: .leading)
                    }
                }
                .foregroundColor(Color.white)
                .frame(width: 330, height: 450, alignment: .topLeading)
                .padding(.top, 10)
            }
        }
    }
}
struct Historique_Previews: PreviewProvider {
    static var previews: some View {
        Historique()
    }
}

// pour afficher la date des commandes en String
func dateToString(datevar : Date) -> String {
    
    // instance of Date
    //let dateToday = Date()
    
    // instance of date formatter
    var dateFormatter = DateFormatter()
    
    // format of our date
    dateFormatter.dateFormat = "dd MMMM yyyy"
    
    // put the in french
    dateFormatter.locale = Locale(identifier: "fr")
    
    // return date
    //return Text(dateFormatter.string(from: dateToday))
    return dateFormatter.string(from: datevar as Date)
}



