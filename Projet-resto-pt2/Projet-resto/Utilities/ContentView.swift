//
//  ContentView.swift
//  Projet-resto
//
//  Created by user213684 on 3/25/22.
// Programmer: Lamia Ouassaa (2678752)
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        
        ZStack{
            NavigationView{
                ZStack{
                    
                    //background color
                    Color.orange.edgesIgnoringSafeArea(.all);
                    VStack{
                        Text("Bienvenue.")
                            .font(.system(size: 50))
                            .bold()
                            .foregroundColor(Color.white)
                        
                        Image(uiImage: UIImage(named: "_logo")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height:300)
                            .clipShape(RoundedRectangle(cornerRadius: 90))
                            .padding(.all,5)
                            .background(Color.purple)
                            .cornerRadius(95)
                        
                        // paragraph
                        Text("C'est comme\nmanger à la maison")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .multilineTextAlignment(.center)

                        Spacer()
                        // Slider
                        sliderView().frame(height: 110)
                        
                    }
                }
           }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct sliderView: View {
    // Propriete qui remet l'item a sa position initiale
    @State private var offset: CGSize = .zero
    //
    @State private var changeView : Bool = false
    
    let firstColor = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
    
    var body: some View {
        
        //NavigationView {
            ZStack{
                //background color
                Color.orange.edgesIgnoringSafeArea(.all);
                
                // $ = binding
                NavigationLink(destination: DeuxiemeVue()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                    .navigationBarTitle(""), isActive: $changeView){
                    EmptyView()
                }
                
                // drag gesture definition
                let dragGesture = DragGesture()
                    .onChanged{ value in
                        self.offset = value.translation
                        // max position the green circle/capsule can go at
                        if(self.offset.width > 178){
                            self.offset.width = 178
                        }
                        else if(self.offset.width < 0){
                            self.offset.width = 0
                        }
                    }
                // when the user finished to slide
                    .onEnded{value in
                        
                        if(self.offset.width > 100){
                            changeView = true
                        }
                        
                        self.offset = CGSize.zero
                    }
                HStack{
                    // Capsule blanche/transparente
                    Capsule()
                        .fill(.white)
                        .overlay(
                            Capsule()
                                .stroke(Color.white, lineWidth: 18)
                                .opacity(0.4)
                        )
                        .foregroundColor(.blue)
                        .frame(width: 300, height: 80)
                        .opacity(0.6)
                    // Text
                        .overlay(Text("Commander")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .position(x: 170, y: 40)
                        )
                        .overlay(
                            
                            //Green circle
                            Capsule().fill(Color(red: 0, green: 255, blue: 0))
                                .frame(width: 100, height: 100).overlay(
                                    Circle().fill(.green)
                                        .overlay(Image(systemName: "chevron.forward.2")
                                            .font(.system(size: 25))
                                            .foregroundColor(.white)
                                        ).frame(width: 80, height: 80)
                                    // puisque le cercle vert bouge plus vite que le bleu, on le ralenti
                                        .offset(x: pow(self.offset.width, 0.025) )
                                )// position de depart
                                .position(x: 45, y: 40)
                            // remet a la position initial
                            // puisque la capsule bleu vert bouge moins vite que le cercle vert, on le speed up
                                .offset(x: pow(self.offset.width, 1.025) )
                            // permet de drag l'item
                                .gesture(dragGesture)
                        )
                }
            }
    }
}

