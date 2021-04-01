//
//  ZoneList.swift
//  festival-jeu
//
//  Created by ayoub moujane on 01/04/2021.
//

import Foundation


protocol ZoneListDelegate {
    func newZoneList()
}


class ZoneList : ObservableObject, Decodable{
        
    private enum CodingKeys: String, CodingKey {
            case zones
        }
    
    var delegate : ZoneListDelegate?

    private(set) var zones = [Zone]()
    
    func new(zones: [Zone]){
        self.zones = zones
        self.delegate?.newZoneList()
    }

}

