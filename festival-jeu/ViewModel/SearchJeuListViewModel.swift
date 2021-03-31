//
//  SearchJeuViewModel.swift
//  festival-jeu
//
//  Created by ayoub moujane on 23/03/2021.
//

import Foundation

import Foundation
import SwiftUI
import Combine

enum JeuListState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded([Jeu])
    case loadingError(Error)
    case newJeux([JeuViewModel])

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .loading(let s)                      : return "loading: \(s)"
        case .loaded(let jeux)                  : return "loaded: \(jeux.count) games"
        case .loadingError(let error)             : return "loadingError: Error loading -> \(error)"
        case .newJeux(let jeux)               : return "newJeu: reset game list with \(jeux.count) games"
        }
    }
    
}


class SearchJeuListViewModel:  JeuListDelegate, ObservableObject{
    
    /// Playlist model of ViewModel
    private(set) var model: JeuList
    
    @Published private(set) var jeux = [JeuViewModel]()

    /// State of new data loading
    @Published var jeuListState : JeuListState = .ready{
        didSet{
            switch self.jeuListState { // state has changed
            case let .loaded(data):    // new data has been loaded, to change all tracks of playlist
                let sortedData = data.sorted(by: { $0.name < $1.name })
                self.model.new(jeux: sortedData)
            default:                   // nothing to do for ViewModel, perhaps for the view
                return
            }
        }
    }
    
    /// initialization
    /// - Parameter jeuList: jeulist model to be the ViewModel
    init(_ jeuList: JeuList){
        self.model = jeuList
        self.model.delegate = self
    }
    
    /// new list of games for the list
    /// - Parameter jeux: games that will compose the list
    func new(jeux: [Jeu]){
        self.model.new(jeux: jeux)
    }
    
    /// add new games to the playlist
    /// - Parameter tracks: tracks to be added to the playlist
    func add(jeux: [Jeu]){
        self.model.add(jeux: jeux)
    }
    
    /// called when jeulist model has changed all its list of games
    func newJeuList() {
        #if DEBUG
        debugPrint("SearchPlvm: newJeuList()")
        #endif
        self.jeux.removeAll()
        for jeu in self.model.jeux{
            self.jeux.append(JeuViewModel(jeu))
        }
        #if DEBUG
        debugPrint("SearchPlvm: playListState = .newTracks")
        #endif
        self.jeuListState = .newJeux(self.jeux)
    }
    
    /// call when a set of tracks has been append to the playlist
    /// - Parameter tracks: tracks to be added
    func jeuListAdded(jeux: [Jeu]) {
        for jeu in jeux{
            self.jeux.append(JeuViewModel(jeu))
        }
        self.jeuListState = .newJeux(self.jeux)
    }
    
    func jeuListModified(jeu: Jeu, index: Int) {
        return // SearchPlaylistViewModel manages loading an entire set of tracks, not individual change of track of the list
    }
    
}
