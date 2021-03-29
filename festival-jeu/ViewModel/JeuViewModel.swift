//
//  JeuViewModel.swift
//  festival-jeu
//
//  Created by ayoub moujane on 23/03/2021.
//

import Foundation

//
//  AlbumViewModel.swift
//  Playlist
//
//  Created by Christophe Fiorio on 18/02/2021.
//

import Foundation
import SwiftUI


class JeuViewModel: Identifiable, Equatable {
    static func == (lhs: JeuViewModel, rhs: JeuViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    @ObservedObject private(set) var model : Jeu
    
    var id : Int{
        return model.id
    }
    var name: String{
        return model.name
    }
    var minPlayer: Int{
        return model.minPlayer
    }
    var maxPlayer: Int{
        return model.maxPlayer
    }
    var age: Int{
        return model.age
    }
    var duration: Int{
        return model.duration
    }
    var instruction: String{
        return model.instruction
    }
    var avantPremiere : Bool{
        return model.avantPremiere
    }
    var editorFK: Int{
        return model.editorFK
    }
    var typeFK: Int{
        return model.typeFK
    }
    init(_ jeu: Jeu){
        self.model = jeu
    }
    
}
