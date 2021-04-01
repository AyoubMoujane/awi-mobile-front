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
    /// games  exposed for an editor
    public var jeux: [Jeu]
    
    
    
    enum CodingKeys: String, CodingKey {
        case id = "idParticipant"
        case name = "nomParticipant"
        case jeux = "jeux"
    }
    
    init(id: Int, name: String, jeux: [Jeu]){
        self.id      = id
        self.name    = name
        self.jeux    = jeux
    }

}

