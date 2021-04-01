//
//  JeuDetailView.swift
//  festival-jeu
//
//  Created by ayoub moujane on 29/03/2021.
//


import SwiftUI


struct JeuDetailView: View {
    
    let jeu : JeuViewModel

    init(jeuViewed: JeuViewModel){
        self.jeu = jeuViewed
    }
        
    var body: some View {
        return VStack{
                Spacer()
            Text("Nom du jeu : \(jeu.name)")
            Text("Consignes : \(jeu.instruction)")
            Text("Age : \(jeu.age)")
//            Text("Nombre Joueurs max : \(jeu.maxPlayer)")
            Text("Nombre Joueurs min : \(jeu.minPlayer)")
            Text("Durée : \(jeu.duration) min")
            Text("Zone: \(jeu.zone.name)")
                Spacer()
            Spacer()
        }
//        .navigationBarTitle(title, displayMode: .inline)
    }
    

}

struct JeuDetailView_Previews: PreviewProvider {
    static var previews: some View {
        JeuDetailView(jeuViewed: JeuViewModel(
                        JeuExpose(id: 1, quantiteExpose: 5,
                                  jeu: Jeu(id: 1,
                                           name: "Dofus",
                                           minPlayer: 1,
                                           maxPlayer: 1,
                                           age: 14,
                                           duration: 180,
                                           instruction: "Voici les instructions",
                                           editorFK: 2,
                                           typeFK:3
                                           )
                                  , zone: ZoneSimple(id: 1, name: "Zone A", festivalFK: 2)
                        )
                        ))
    }
}
