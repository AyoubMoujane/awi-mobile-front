//
//  EditeurViewModel.swift
//  festival-jeu
//
//  Created by Pierre Perrin on 01/04/2021.
//


import Foundation
import SwiftUI

class EditeurViewModel: Identifiable, Equatable {
    static func == (lhs: EditeurViewModel, rhs: EditeurViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    @ObservedObject private(set) var model : Editeur
    
    var id : Int{
        return model.id
    }
    var name: String{
        return model.name
    }
    var jeux: [Jeu]{
        return model.jeux
    }
    
    init(_ editeur: Editeur){
        self.model = editeur
    }
    
}
