//
//  JeuList.swift
//  festival-jeu
//
//  Created by ayoub moujane on 23/03/2021.
//

import Foundation


protocol JeuListDelegate {
    func jeuListModified(jeu: Jeu, index: Int)
    func newJeuList()
    func jeuListAdded(jeux: [Jeu])
}


class JeuList : ObservableObject, Decodable{
        
    private enum CodingKeys: String, CodingKey {
            case jeux
        }
    
    var delegate : JeuListDelegate?

    private(set) var jeux = [Jeu]()
    
    func add(jeu: Jeu){
        self.jeux.append(jeu)
        self.delegate?.jeuListModified(jeu: jeu, index: self.jeux.count-1)
    }
    func new(jeux: [Jeu]){
        self.jeux = jeux
        self.delegate?.newJeuList()
    }
    func add(jeux: [Jeu]){
        self.jeux.append(contentsOf: jeux)
        self.delegate?.jeuListAdded(jeux: jeux)
    }
}

