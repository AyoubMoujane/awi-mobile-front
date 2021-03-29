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
            Text("Consignes :\(jeu.instruction)")
                Spacer()
            Spacer()
        }
//        .navigationBarTitle(title, displayMode: .inline)
    }
    

}

//struct JeuDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        let jvm = JeuViewModel(Jeu(id: 1, name: "Dofus", minPlayer: 1, maxPlayer: 1, age: 14, duration: 180, instruction: "Voici les instructions", avantPremiere: 0, editorFK: 2, typeFK:3))
//        return {
//            JeuDetailView(jvm)
//        }
//    }
//}
