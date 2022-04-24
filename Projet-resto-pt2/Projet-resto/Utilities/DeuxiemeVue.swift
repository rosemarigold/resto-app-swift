//
//  DeuxiemeVue.swift
//  Projet-resto
//
//  Created by user213684 on 3/25/22.
//
/* Source: https://stackoverflo .com/questions/59141688/swiftui-change-list-row-highlight-colour-when-tapped*/

import SwiftUI

struct DeuxiemeVue: View {
    
    // objet qui contient un tableau des items du menu
    @ObservedObject var menuStore: MenuStore = MenuStore(menuData);
    
    // pour afficher le symbol en combo
    var imageCombo = ""
    
    // pour afficher l'historique
    @State private var afficherHistorique: Bool = false
  
    var body: some View {
        
        ZStack{
            //background color
            Color.orange
                .edgesIgnoringSafeArea(.all)
                .overlay(Rectangle()
                    .fill(.white)
                    .frame(width: 400, height: 650)
                    .offset(y:-15)
                );
            
            // Bouton Payer
            HStack{
                NavigationLink(destination: TroisiemeVue(menuStore: menuStore)
                               //to hide the back button
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                    .navigationBarTitle("")){
                        Capsule()
                            .fill(.green)
                            .frame(width: 120, height: 40)
                            .overlay(
                                HStack{
                                    Image(systemName: "cart").foregroundColor(.black)
                                    Text("PAYER").foregroundColor(.black)
                                }
                            )
                    }.offset(x:120, y:-370)
            }
            
            HStack{
                Button {
                    afficherHistorique.toggle()
                } label: {
                    Text("Historique").foregroundColor(Color.purple).fontWeight(.bold)
                }
            }.sheet(isPresented: $afficherHistorique) {
                Historique()
            }.offset(x:-135, y:-370)
            
            
            // Menu
            VStack{
                List{
                    // Section #1 - Main
                    Section(header: Text("Repas principal"), content:{
                        // display menu item
                        
                        // 1-hamburger
                        HStack{
                            Text(menuStore.menu[0].name)
                            // space character to fill the HStack and make
                            // clickable everywhere
                            Text("                                                  ")
                            // add bag icon at the right
                            if(menuStore.menu[0].isCombo == true){
                                Spacer() // align image on right
                                Image(systemName: "bag.badge.plus")
                            }
                        }.border(Color.clear, width: 1)
                        .onTapGesture(count: 2)  {
                            if(menuStore.menu[0].isSelected == true){
                                menuStore.menu[0].isSelected = false;
                            }
                            else if(menuStore.menu[0].isSelected == false){
                                menuStore.menu[0].isSelected = true;
                            }
                        }
                        // met l'item en mauve si selectionne
                        .listRowBackground(menuStore.menu[0].isSelected == true ? Color.purple : Color.white )
                        // met le texte en blanc si selectionne
                        .foregroundColor(menuStore.menu[0].isSelected == true ? Color.white : Color.black )
                        // Context Menu (on long press)
                        .contextMenu{
                            Button(action: { // item is in a combo
                                menuStore.menu[0].isCombo = true
                                menuStore.menu[0].isSelected = true
                            }){
                                HStack{
                                    Text("EN COMBO")
                                    Image(systemName: "bag.badge.plus")
                                }
                            }
                            Button(action: { // item is not in a combo
                                menuStore.menu[0].isCombo = false
                            }){
                                HStack{
                                    Text("ITEM UNIQUEMENT")
                                }
                            }
                        }
                        
                        // 2-pogo
                        HStack{
                            Text(menuStore.menu[1].name)
                            // space character to fill the HStack and make
                            // clickable everywhere
                            Text("                                                  ")
                            // add bag icon at the right
                            if(menuStore.menu[1].isCombo == true){
                                Spacer() // algin image on right
                                Image(systemName: "bag.badge.plus")
                            }
                        }
                        .onTapGesture(count: 2)  {
                            if(menuStore.menu[1].isSelected == true){
                                menuStore.menu[1].isSelected = false;
                            }
                            else if(menuStore.menu[1].isSelected == false){
                                menuStore.menu[1].isSelected = true;
                            }
                        }
                        // met l'item en mauve si selectionne
                        .listRowBackground(menuStore.menu[1].isSelected == true ? Color.purple : Color.white)
                        // met le texte en blanc si selectionne
                        .foregroundColor(menuStore.menu[1].isSelected == true ? Color.white : Color.black )
                        // Context Menu (on long press)
                        .contextMenu{
                            Button(action: { // item is in a combo
                                menuStore.menu[1].isCombo = true
                                menuStore.menu[1].isSelected = true
                            }){
                                HStack{
                                    Text("EN COMBO")
                                    Image(systemName: "bag.badge.plus")
                                }
                            }
                            Button(action: { // item is not in a combo
                                menuStore.menu[1].isCombo = false
                            }){
                                HStack{
                                    Text("ITEM UNIQUEMENT")
                                }
                            }
                        }
                        
                        // 3-pizza
                        HStack{
                            Text(menuStore.menu[2].name)
                            // space character to fill the HStack and make
                            // clickable everywhere
                            Text("                                                  ")
                            // add bag icon at the right
                            if(menuStore.menu[2].isCombo == true){
                                Spacer() // algin image on right
                                Image(systemName: "bag.badge.plus")
                            }
                        }
                        .onTapGesture(count: 2)  {
                            if(menuStore.menu[2].isSelected == true){
                                menuStore.menu[2].isSelected = false;
                            }
                            else if(menuStore.menu[2].isSelected == false){
                                menuStore.menu[2].isSelected = true;
                            }
                        }
                        // met l'item en mauve si selectionne
                        .listRowBackground(menuStore.menu[2].isSelected == true ? Color.purple : Color.white)
                        // met le texte en blanc si selectionne
                        .foregroundColor(menuStore.menu[2].isSelected == true ? Color.white : Color.black )
                        // Context Menu (on long press)
                        .contextMenu{
                            Button(action: { // item is in a combo
                                menuStore.menu[2].isCombo = true
                                menuStore.menu[2].isSelected = true
                            }){
                                HStack{
                                    Text("EN COMBO")
                                    Image(systemName: "bag.badge.plus")
                                }
                            }
                            Button(action: { // item is not in a combo
                                menuStore.menu[2].isCombo = false
                            }){
                                HStack{
                                    Text("ITEM UNIQUEMENT")
                                }
                            }
                        }
                    })
                    // Section #2 - Side
                    Section(header: Text("À côtés"), content:{
                        // display menu item
                        // frites
                        HStack{
                            Text(menuStore.menu[3].name)
                            // space character to fill the HStack and make
                            // clickable everywhere
                            Text("                                                              ")
                        }
                        .onTapGesture(count: 2)  {
                            if(menuStore.menu[3].isSelected == true){
                                menuStore.menu[3].isSelected = false;
                            }
                            else if(menuStore.menu[3].isSelected == false){
                                menuStore.menu[3].isSelected = true;
                            }
                        }
                        // met l'item en mauve si selectionne
                        .listRowBackground(menuStore.menu[3].isSelected == true ? Color.purple : Color.white)
                        // met le texte en blanc si selectionne
                        .foregroundColor(menuStore.menu[3].isSelected == true ? Color.white : Color.black )
                        
                        // boisson
                        HStack{
                            Text(menuStore.menu[4].name)
                            // space character to fill the HStack and make
                            // clickable everywhere
                            Text("                                                            ")
                        }
                        .onTapGesture(count: 2)  {
                            if(menuStore.menu[4].isSelected == true){
                                menuStore.menu[4].isSelected = false;
                            }
                            else if(menuStore.menu[4].isSelected == false){
                                menuStore.menu[4].isSelected = true;
                            }
                        }
                        // met l'item en mauve si selectionne
                        .listRowBackground(menuStore.menu[4].isSelected == true ? Color.purple : Color.white)
                        // met le texte en blanc si selectionne
                        .foregroundColor(menuStore.menu[4].isSelected == true ? Color.white : Color.black )
                    })
                }
                .frame(width: 390, height: 650)//.offset(y:30)
                .listStyle(PlainListStyle())
            }
            
            // bouton quitter
            BoutonQuitter().offset(y:325)
        }
    }
}

struct DeuxiemeVue_Previews: PreviewProvider {
    static var previews: some View {
        DeuxiemeVue()
    }
}

struct BoutonQuitter: View{
    //
    @State private var event : Bool = false

    var body: some View {
    
        // variable du long press
        let longPress = LongPressGesture(minimumDuration: 3)
            .onEnded{ value in
                event = true
        }
        
        // bouton quitter
        return HStack{
            NavigationLink(destination: ContentView()
                           //to hide the back button
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .navigationBarTitle(""), isActive: $event){
                    Capsule()
                        .fill(.green)
                        .frame(width: 300, height: 80)
                        .overlay(
                            HStack{ Text("QUITTER")
                                .foregroundColor(.black)
                            }
                        )
                }.offset(y:35)
        }.gesture(longPress)
    }
}

