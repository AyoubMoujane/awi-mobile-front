//
//  SearchZoneListViewModel.swift
//  festival-jeu
//
//  Created by ayoub moujane on 01/04/2021.
//

import Foundation

import Foundation
import SwiftUI
import Combine

enum ZoneListState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded([Zone])
    case loadingError(Error)
    case newZones([ZoneViewModel])

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .loading(let s)                      : return "loading: \(s)"
        case .loaded(let zones)                  : return "loaded: \(zones.count) games"
        case .loadingError(let error)             : return "loadingError: Error loading -> \(error)"
        case .newZones(let zones)               : return "newZones: reset zone list with \(zones.count) zones"
        }
    }
    
}


class SearchZoneListViewModel:  ZoneListDelegate, ObservableObject{
    
    /// ZoneList model of ViewModel
    private(set) var model: ZoneList
    
    @Published private(set) var zones = [ZoneViewModel]()

    /// State of new data loading
    @Published var zoneListState : ZoneListState = .ready{
        didSet{
            switch self.zoneListState { // state has changed
            case let .loaded(data):    // new data has been loaded, to change all games of list
                let sortedData = data.sorted(by: { $0.name < $1.name })
                new(zones: sortedData)
            default:                   // nothing to do for ViewModel, perhaps for the view
                return
            }
        }
    }
    
    /// initialization
    /// - Parameter jeuList: jeulist model to be the ViewModel
    init(_ zoneList: ZoneList){
        self.model = zoneList
        self.model.delegate = self
    }
    
    /// new list of games for the list
    /// - Parameter jeux: games that will compose the list
    func new(zones: [Zone]){
        self.model.new(zones: zones)
    }
    
    /// called when jeulist model has changed all its list of games
    func newZoneList() {
        #if DEBUG
        debugPrint("SearchJlvm: newJeuList()")
        #endif
        self.zones.removeAll()
        for zone in self.model.zones{
            self.zones.append(ZoneViewModel(zone))
        }
        #if DEBUG
        debugPrint("SearchJlvm: zoneListState = .newZones")
        #endif
        self.zoneListState = .newZones(self.zones)
    }
    
}
