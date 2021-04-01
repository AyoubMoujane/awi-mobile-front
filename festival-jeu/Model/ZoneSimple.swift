//
//  ZoneSimple.swift
//  festival-jeu
//
//  Created by ayoub moujane on 01/04/2021.
//

import Foundation
import SwiftUI
import Combine


class ZoneSimple : Identifiable, ObservableObject, Codable, Equatable{
    static func == (lhs: ZoneSimple, rhs: ZoneSimple) -> Bool {
        return lhs.id == rhs.id
    }
    
    /// id of the game
    private(set) var id : Int
    /// name of the game
    public var name: String
    /// id of the festival the zone belongs to
    private(set) var festivalFK: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "idZone"
        case name = "nomZone"
        case festivalFK = "festivalFK"
    }
    
    init(id: Int, name: String, festivalFK: Int){
        self.id      = id
        self.name    = name
        self.festivalFK = festivalFK
    }

}
