//
//  Jeu.swift
//  festival-jeu
//
//  Created by ayoub moujane on 23/03/2021.
//

import Foundation
import SwiftUI
import Combine


class Jeu : Identifiable, ObservableObject, Codable, Equatable{
    static func == (lhs: Jeu, rhs: Jeu) -> Bool {
        return lhs.id == rhs.id
    }
    
    /// id of the festival
    private(set) var id : Int
    /// name of the track (song)
    public var name: String
    /// date of the festival
    private(set) var minPlayer: Int
    /// date of the festival
    private(set) var maxPlayer: Int
    /// date of the festival
    private(set) var age: Int
    /// date of the festival
    private(set) var duration: Int
    /// is the festival current
    private(set) var instruction: String
    /// date of the festival
    private(set) var avantPremiere: Bool
    /// date of the festival
    private(set) var editorFK: Int
    /// date of the festival
    private(set) var typeFK: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "idJeu"
        case name = "nomJeu"
        case minPlayer = "nbJoueurMin"
        case maxPlayer = "nbJoueurMax"
        case age = "age"
        case duration = "duree"
        case instruction = "consigne"
        case avantPremiere = "prototype"
        case editorFK = "editeur"
        case typeFK = "type"
    }
    
    /// initialization of a track
    /// - Parameters:
    ///   - id: unique id
    ///   - name: name of the festival
    ///   - date: festival date
    ///   - estCourant: is current festival
    init(id: Int, name: String, minPlayer: Int, maxPlayer: Int, age: Int, duration: Int, instruction: String, avantPremiere: Bool, editorFK: Int, typeFK: Int){
        self.id      = id
        self.name    = name
        self.minPlayer   = minPlayer
        self.maxPlayer = maxPlayer
        self.age = age
        self.duration = duration
        self.instruction = instruction
        self.avantPremiere = avantPremiere
        self.editorFK = editorFK
        self.typeFK = typeFK
    }

}

