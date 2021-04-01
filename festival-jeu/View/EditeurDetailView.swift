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
        return VStack{
                Spacer()
            Text("Nom Editeur : \(editeur.name)")
            Text("Nombre de jeux exposés pour cet éditeur :\(editeur.jeux.count)")
            Spacer()
            ForEach(editeur.jeux){ jeu in
                Text("Nom : \(jeu.name)")
                Text("Consignes: \(jeu.instruction)")
            }
            Spacer()
        }
    }
}

struct EditeurDetail_Previews: PreviewProvider {
    static var previews: some View {
        EditeurDetailView(editeurViewed:EditeurViewModel(Editeur(id:1,name:"pierre", jeux: [Jeu]())))
    }
}
