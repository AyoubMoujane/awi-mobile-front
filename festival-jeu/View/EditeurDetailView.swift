//
//  EditeurDetail.swift
//  festival-jeu
//
//  Created by Pierre Perrin on 01/04/2021.
//

import SwiftUI

struct EditeurDetailView: View {
    
    let editeur : EditeurViewModel
    
    init(editeurViewed: EditeurViewModel){
        self.editeur = editeurViewed
    }
    
    var body: some View {
        
        return ScrollView(){
            VStack(alignment: .leading, spacing: 20){
                Text("\(editeur.name)")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Text("Nombre de jeux exposés par cet éditeur : \(editeur.jeux.count)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                ForEach(editeur.jeux){ jeu in
                    VStack(alignment: .leading, spacing: 20){
                        Spacer()
                        Text("Jeu: \(jeu.name)")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.red)
                        Text("Consignes: \(jeu.instruction)")
                        Text("Durée partie: \(jeu.duration) min")
                        Spacer()
                    }
                    
                }
                Spacer()
            }.padding(50)
        }
//        return VStack{
//                Spacer()
//            Text("Nom Editeur : \(editeur.name)")
//            Text("Nombre de jeux exposés pour cet éditeur :\(editeur.jeux.count)")
//            Spacer()
//            ForEach(editeur.jeux){ jeu in
//                Text("Nom : \(jeu.name)")
//                Text("Consignes: \(jeu.instruction)")
//            }
//            Spacer()
//        }
    }
}

struct EditeurDetail_Previews: PreviewProvider {
    static var previews: some View {
        EditeurDetailView(editeurViewed:EditeurViewModel(Editeur(id:1,name:"pierre", jeux: [Jeu]())))
    }
}
