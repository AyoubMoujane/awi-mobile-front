//
//  Editeur.swift
//  festival-jeu
//
//  Created by Pierre Perrin on 01/04/2021.
//

import Foundation


class Editeur : Identifiable, ObservableObject, Codable, Equatable{
    static func == (lhs: Editeur, rhs: Editeur) -> Bool {
        return lhs.id == rhs.id
    }
    
    /// id of the editor
    private(set) var id : Int
    /// name of the editor
    public var name: String
    
    
    
    enum CodingKeys: String, CodingKey {
        case id = "idEditor"
        case name = "nomEditor"
    }
    
    init(id: Int, name: String){
        self.id      = id
        self.name    = name
    }

}

