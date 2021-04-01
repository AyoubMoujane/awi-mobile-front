//
//  Zone.swift
//  festival-jeu
//
//  Created by ayoub moujane on 01/04/2021.
//

import Foundation
import SwiftUI
import Combine


class Zone : Identifiable, ObservableObject, Codable, Equatable{
    static func == (lhs: Zone, rhs: Zone) -> Bool {
        return lhs.id == rhs.id
    }
    
    /// id of the game
    private(set) var id : Int
    /// name of the game
    public var name: String
    /// id of the festival the zone belongs to
    private(set) var festivalFK: Int
    /// games in the zone
    public var jeux: [JeuExpose]
    
    enum CodingKeys: String, CodingKey {
        case id = "idZone"
        case name = "nomZone"
        case festivalFK = "festivalFK"
        case jeux = "jeux"
    }
    
    init(id: Int, name: String, festivalFK: Int, jeux: [JeuExpose]){
        self.id      = id
        self.name    = name
        self.festivalFK = festivalFK
        self.jeux = jeux
    }

}
