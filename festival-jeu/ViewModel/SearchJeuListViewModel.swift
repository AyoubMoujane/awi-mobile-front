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
        case .loaded(let jeux)                  : return "loaded: \(jeux.count) tracks"
        case .loadingError(let error)             : return "loadingError: Error loading -> \(error)"
        case .newJeux(let jeux)               : return "newJeu: reset game list with \(jeux.count) games"
        }
    }
    
}


class SearchJeuListViewModel:  JeuListDelegate, ObservableObject{
    
    /// Playlist model of ViewModel
    private(set) var model: JeuList
    
    /// tracks of TrackViewModel synchronized with tracks of playlist model
    @Published private(set) var jeux = [JeuViewModel]()
    
    @Published var trackAddingError : Bool = false{
        didSet{
            if !trackAddingError{
                jeuListState = .ready
            }
        }
    }
    /// disclosure form is opened or closed according to a bool
    /// idealy, we should set this bool in SearchListView to false when state becomes .loaded or .loadingError
    /// but this bool has to be a @State var or a @Published var and change of state will be observed in view when the body has to be recomputed,
    /// i.e. when view is redisplayed, and  change in @State var or @Published var are not taken into account during a view drawing
    /// so the bool will not change and disclosure will not be closed
    /// It is why, the viewmodel handles this bool and tell the view when close the disclosure according to state change
    @Published var formViewOpen = false

    /// State of new data loading for playlist
    @Published var jeuListState : JeuListState = .ready{
        didSet{
            #if DEBUG
            debugPrint("SearchPlvm : state.didSet = \(jeuListState)")
            #endif
            switch self.jeuListState { // state has changed
            case let .loaded(data):    // new data has been loaded, to change all tracks of playlist
                self.formViewOpen = false // close searchFormView, new tracks have been found
                #if DEBUG
                debugPrint("SearchPlvm: track loaded => formViewOpen=\(formViewOpen) -> model.new(tracks:)")
                #endif
                let sortedData = data.sorted(by: { $0.name < $1.name })
                self.model.new(jeux: sortedData)
            case .loadingError:
                self.formViewOpen = true // reopen or keep open searchFormView as there is an error on loading new tracks
            default:                   // nothing to do for ViewModel, perhaps for the view
                return
            }
        }
    }
    
    /// initialization
    /// - Parameter playlist: playlist model to be the ViewModel
    init(_ jeuList: JeuList){
        self.model = jeuList
        self.model.delegate = self
    }
    
    /// new list of tracks for the playlist
    /// - Parameter tracks: tracks that will define the playlist
    func new(jeux: [Jeu]){
        #if DEBUG
        debugPrint("SearchPlvm: model.new(tracks:) with \(jeux.count) tracks")
        #endif
        self.model.new(jeux: jeux)
    }
    
    /// add new tracks to the playlist
    /// - Parameter tracks: tracks to be added to the playlist
    func add(jeux: [Jeu]){
        self.model.add(jeux: jeux)
    }
    
    /// erase playlist
    func removeAllTracks(){
        self.model.removeAllTracks()
    }
    
    // ---------------------------------------------------------------------------------------------------------
    // MARK: -
    // MARK: Playlist delegate
    
    /// called when playlist model has been modified
    ///
    /// if index exists, then this track has replaced the track already there, else track has been append to the list.
    /// - Parameters:
    ///   - track: track that is put into the list
    ///   - index: index where to set the track
    /// called when playlist model has been deleted
    func jeuListDeleted(){
        self.jeux.removeAll()
    }
    /// called when playlist model has changed all its list of tracks
    func newJeuList() {
        #if DEBUG
        debugPrint("SearchPlvm: newPlaylist()")
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
