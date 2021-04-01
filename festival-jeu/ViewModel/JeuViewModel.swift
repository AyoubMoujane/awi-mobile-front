//
//  JeuViewModel.swift
//  festival-jeu
//
//  Created by ayoub moujane on 23/03/2021.
//

import Foundation
import SwiftUI


class JeuViewModel: Identifiable, Equatable {
    static func == (lhs: JeuViewModel, rhs: JeuViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    @ObservedObject private(set) var model : JeuExpose
    
    var id : Int{
        return model.id
    }
    var name: String{
        return model.jeu.name
    }
    var minPlayer: Int{
        return model.jeu.minPlayer
    }
    var maxPlayer: Int{
        return model.jeu.maxPlayer
    }
    var age: Int{
        return model.jeu.age
    }
    var duration: Int{
        return model.jeu.duration
    }
    var instruction: String{
        return model.jeu.instruction
    }
    var editorFK: Int{
        return model.jeu.editorFK
    }
    var typeFK: Int{
        return model.jeu.typeFK
    }
    var zone: ZoneSimple{
        return model.zone
    }
    var editeur: EditeurSimple{
        return model.jeu.editeurSimple
    }
    
    init(_ jeu: JeuExpose){
        self.model = jeu
    }
    
}
