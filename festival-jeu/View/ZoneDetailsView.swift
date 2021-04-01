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
        return ScrollView(){
            VStack(alignment: .leading, spacing: 20){
                Spacer()
                Text("\(zone.name)")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Text("Nombre de jeux: \(zone.jeux.count)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                ForEach(zone.jeux){ jeu in
                    VStack(alignment: .leading, spacing: 20){
                        Spacer()
                        Text("Jeu: \(jeu.jeu.name)")
                        if let qte=jeu.quantiteExpose{
                            Text("quantité présentée: \(qte)")
                        }
                        Text("Durée partie: \(jeu.jeu.duration) min")
                        Spacer()
                    }
                    
                }
                Spacer()
            }.padding(100)
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
        
        let jeuExp1 = JeuExposeSimple(id:1,quantiteExpose:5,jeu: jeu1)
        let jeuExp2 = JeuExposeSimple(id:2,quantiteExpose:10,jeu: jeu2)
        
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
