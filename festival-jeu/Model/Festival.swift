//
//  Festival.swift
//  festival-jeu
//
//  Created by ayoub moujane on 23/03/2021.
//

import Foundation
import SwiftUI
import Combine


class Festival : Identifiable, ObservableObject, Encodable, Equatable{
    static func == (lhs: Festival, rhs: Festival) -> Bool {
        return lhs.id == rhs.id
    }
    
    /// id of the festival
    private(set) var id : Int
    /// name of the track (song)
    private(set) var name: String
    /// date of the festival
    private(set) var date: Date
    /// is the festival current
    private(set) var estCourant: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "idFestival"
        case name = "nomFestival"
        case date = "dateFestival"
        case estCourant = "estCourant"
    }
    
    /// initialization of a track
    /// - Parameters:
    ///   - id: unique id
    ///   - name: name of the festival
    ///   - date: festival date
    ///   - estCourant: is current festival
    init(id: Int, name: String, date: Date, estCourant: Bool){
        self.id      = id
        self.name    = name
        self.date   = date
        self.estCourant = estCourant
    }

}
