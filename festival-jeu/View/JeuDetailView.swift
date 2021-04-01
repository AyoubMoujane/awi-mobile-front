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
        
        return  ScrollView(){
            VStack(alignment: .leading, spacing: 20){
                    Text("\(jeu.name)")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text("Zone: \(jeu.zone.name)")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.red)
                
                    Text("Editeur: \(jeu.editeur.name)")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.red)
                    Spacer()
                    Text("Consignes : \(jeu.instruction)")
                    Spacer()
                    Text("Age : \(jeu.age)")
                    Text("Nombre joueurs min : \(jeu.minPlayer)")
                    Text("Durée : \(jeu.duration) min")
                }.padding(50)
            }
        }
    

}

struct JeuDetailView_Previews: PreviewProvider {
    static var previews: some View {
        JeuDetailView(jeuViewed: JeuViewModel(
                        JeuExpose(id: 1, quantiteExpose: 5,
                                  jeu: JeuComplexe(id: 1,
                                           name: "Dofus",
                                           minPlayer: 1,
                                           maxPlayer: 1,
                                           age: 14,
                                           duration: 180,
                                           instruction: "Voici les instructions",
                                           editorFK: 2,
                                           typeFK:3,
                                           editeurSimple: EditeurSimple(id: 1, name: "ANKAMA")
                                           )
                                  ,zone: ZoneSimple(id: 1, name: "Zone A", festivalFK: 2)
                                  
                        )
                        ))
    }
}
