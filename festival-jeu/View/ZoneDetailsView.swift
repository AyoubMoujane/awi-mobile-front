//
//  ZoneDetails.swift
//  festival-jeu
//
//  Created by ayoub moujane on 01/04/2021.
//

import SwiftUI


struct ZoneDetailsView: View {
    
    let zone : ZoneViewModel

    init(zoneViewed: ZoneViewModel){
        self.zone = zoneViewed
    }
        
    var body: some View {
        return VStack{
                Spacer()
            Text("Nom Zone: \(zone.name)")
            Text("Nombre de jeux dans la zone :\(zone.jeux.count)")
            Spacer()
            ForEach(zone.jeux){ jeu in
                Text("Nom : \(jeu.jeu.name)")
                Text("Consignes: \(jeu.jeu.instruction)")
            }
            Spacer()
        }
//        .navigationBarTitle(title, displayMode: .inline)
    }
    

}

struct ZoneDetailsView_Previews: PreviewProvider {
    

    static var previews: some View {
        let jeu1 = Jeu(id: 1,
                       name: "Dofus",
                       minPlayer: 1,
                       maxPlayer: 1,
                       age: 14,
                       duration: 180,
                       instruction: "Voici les instructions1",
                       editorFK: 2,
                       typeFK:3)
        let jeu2 = Jeu(id: 1,
                        name: "Monopoly",
                        minPlayer: 1,
                        maxPlayer: 1,
                        age: 14,
                        duration: 180,
                        instruction: "Voici les instructions2",
                        editorFK: 2,
                        typeFK:3)
        
        let jeuExp1 = JeuExpose(id:1,quantiteExpose:5,jeu: jeu1)
        let jeuExp2 = JeuExpose(id:2,quantiteExpose:10,jeu: jeu2)
        
        ZoneDetailsView(zoneViewed: ZoneViewModel(Zone(id:1,name:"Zone A",festivalFK:1,
                                                       jeux:[jeuExp1,jeuExp2]
        )))
                                                        
    }
}

//init(id: Int, name: String, festivalFK: Int, jeux: [JeuExpose]){
//    self.id      = id
//    self.name    = name
//    self.festivalFK = festivalFK
//    self.jeux = jeux
//}

//            jeuViewed: JeuViewModel(
//                        Jeu(id: 1,
//                            name: "Dofus",
//                            minPlayer: 1,
//                            maxPlayer: 1,
//                            age: 14,
//                            duration: 180,
//                            instruction: "Voici les instructions",
//                            editorFK: 2,
//                            typeFK:3))
