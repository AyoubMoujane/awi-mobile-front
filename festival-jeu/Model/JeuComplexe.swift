//
//  JeuComplexe.swift
//  festival-jeu
//
//  Created by ayoub moujane on 01/04/2021.
//

import Foundation
import SwiftUI
import Combine


class JeuComplexe : Identifiable, ObservableObject, Codable, Equatable{
    static func == (lhs: JeuComplexe, rhs: JeuComplexe) -> Bool {
        return lhs.id == rhs.id
    }
    
    /// id of the game
    private(set) var id : Int
    /// name of the game
    public var name: String
    /// minimum number of players for the game
    private(set) var minPlayer: Int
    /// maximum number of players of the game
    private(set) var maxPlayer: Int
    /// age minimum for the game
    private(set) var age: Int
    /// duration of the game
    private(set) var duration: Int
    /// game instruction
    private(set) var instruction: String
    /// id of the game editor
    private(set) var editorFK: Int
    /// id of the game type
    private(set) var typeFK: Int
    /// id of the game type
    private(set) var editeurSimple: EditeurSimple
    
    enum CodingKeys: String, CodingKey {
        case id = "idJeu"
        case name = "nomJeu"
        case minPlayer = "nbJoueurMin"
        case maxPlayer = "nbJoueurMax"
        case age = "age"
        case duration = "duree"
        case instruction = "consigne"
        case editorFK = "editeur"
        case typeFK = "type"
        case editeurSimple = "participant"

    }
    
    init(id: Int, name: String, minPlayer: Int, maxPlayer: Int, age: Int, duration: Int, instruction: String, editorFK: Int, typeFK: Int, editeurSimple: EditeurSimple){
        self.id      = id
        self.name    = name
        self.minPlayer   = minPlayer
        self.maxPlayer = maxPlayer
        self.age = age
        self.duration = duration
        self.instruction = instruction
        self.editorFK = editorFK
        self.typeFK = typeFK
        self.editeurSimple = editeurSimple
    }

}

