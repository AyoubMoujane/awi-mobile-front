//
//  ZoneViewModel.swift
//  festival-jeu
//
//  Created by ayoub moujane on 01/04/2021.
//

import Foundation
import SwiftUI


class ZoneViewModel: Identifiable, Equatable {
    static func == (lhs: ZoneViewModel, rhs: ZoneViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    @ObservedObject private(set) var model : Zone
    
    var id : Int{
        return model.id
    }
    var name: String{
        return model.name
    }
    var jeux: [JeuExposeSimple]{
        return model.jeux
    }
    init(_ zone: Zone){
        self.model = zone
    }
    
}

