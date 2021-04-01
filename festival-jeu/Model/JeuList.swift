//
//  JeuList.swift
//  festival-jeu
//
//  Created by ayoub moujane on 23/03/2021.
//

import Foundation


protocol JeuListDelegate {
    func newJeuList()
}


class JeuList : ObservableObject, Decodable{
        
    private enum CodingKeys: String, CodingKey {
            case jeux
        }
    
    var delegate : JeuListDelegate?

    private(set) var jeux = [JeuExpose]()
    
    func new(jeux: [JeuExpose]){
        self.jeux = jeux
        self.delegate?.newJeuList()
    }

}

