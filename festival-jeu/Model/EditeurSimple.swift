//
//  EditeurSimple.swift
//  festival-jeu
//
//  Created by ayoub moujane on 01/04/2021.
//

import Foundation


class EditeurSimple : Identifiable, ObservableObject, Codable, Equatable{
    static func == (lhs: EditeurSimple, rhs: EditeurSimple) -> Bool {
        return lhs.id == rhs.id
    }
    
    /// id of the editor
    private(set) var id : Int
    /// name of the editor
    public var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idParticipant"
        case name = "nomParticipant"
    }
    
    init(id: Int, name: String){
        self.id      = id
        self.name    = name
    }

}
