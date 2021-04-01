//
//  EditeurList.swift
//  festival-jeu
//
//  Created by Pierre Perrin on 01/04/2021.
//

import Foundation


protocol EditeurListDelegate {
    func newEditeurList()
}


class EditeurList : ObservableObject, Decodable{
        
    private enum CodingKeys: String, CodingKey {
            case editeurs
        }
    
    var delegate : EditeurListDelegate?

    private(set) var editeurs = [Editeur]()
    
    func new(editeurs: [Editeur]){
        self.editeurs = editeurs
        self.delegate?.newEditeurList()
    }

}
