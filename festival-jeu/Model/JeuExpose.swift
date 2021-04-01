//
//  JeuExpose.swift
//  festival-jeu
//
//  Created by ayoub moujane on 01/04/2021.
//

import Foundation
import SwiftUI
import Combine


class JeuExpose : Identifiable, ObservableObject, Codable, Equatable{
    static func == (lhs: JeuExpose, rhs: JeuExpose) -> Bool {
        return lhs.id == rhs.id
    }
    
    /// id of the reservation
    private(set) var id : Int
    /// number of displayed games
    public var quantiteExpose: Int?
    /// game presented
    public var jeu: Jeu
    
    enum CodingKeys: String, CodingKey {
        case id = "idReservation"
        case quantiteExpose = "quantiteExpose"
        case jeu = "jeu"
    }
    
    init(id: Int, quantiteExpose: Int, jeu: Jeu){
        self.id      = id
        self.quantiteExpose = quantiteExpose
        self.jeu = jeu
    }

}
