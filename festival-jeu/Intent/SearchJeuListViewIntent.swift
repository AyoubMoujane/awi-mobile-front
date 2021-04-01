//
//  JeuViewIntent.swift
//  festival-jeu
//
//  Created by ayoub moujane on 23/03/2021.
//

import Foundation
import SwiftUI



class SearchJeuListViewIntent{
    
    @ObservedObject var jeuList : SearchJeuListViewModel
    
    init(jeuList: SearchJeuListViewModel){
        self.jeuList = jeuList
    }
        
    func loaded(jeux: [Jeu]){
        #if DEBUG
        debugPrint("SearchIntent: \(self.jeuList.jeuListState) => \(jeux.count) tracks loaded")
        #endif
        self.jeuList.jeuListState = .ready
    }
    
    func httpJsonLoaded(result: Result<[JeuExpose], HttpRequestError>){
        switch result {
        case let .success(data):
            #if DEBUG
            debugPrint("SearchIntent: httpJsonLoaded -> success -> .loaded(tracks)")
            #endif
//            if let artist = artistFilter{
//                let tracks = data.filter( { track in track.artist.lowercased().contains(artist.lowercased()) } )
//                playlist.playListState = .loaded(tracks)
//            }
//            else{
            jeuList.jeuListState = .loaded(data)
//            }
        case let .failure(error):
            jeuList.jeuListState = .loadingError(error)
        }
    }
    
    func jeuLoaded(){
        #if DEBUG
        debugPrint("SearchIntent: track deleted => save data")
        #endif
        jeuList.jeuListState = .ready
    }

    var artistFilter : String? = nil

    func loadJeux(url : String, artistFilter: String?){
        self.artistFilter = artistFilter
        #if DEBUG
        debugPrint("SearchIntent: .loading(\(url))")
        debugPrint("SearchIntent: asyncLoadTracks")
        #endif
        jeuList.jeuListState = .loading(url)
//        ITunesTrackHelper.loadTracksFromAPI(url: url, endofrequest: httpJsonLoaded)
    }
    
    func loadData() {
        
        var re = [JeuExpose]()

        
        jeuList.jeuListState = .loading("http://localhost:8080/api/custom/jeuxExposes")
        let surl = "http://localhost:8080/api/custom/jeuxExposes"
        guard let url = URL(string: surl) else { print("rien"); return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data,response,error in
            guard let data = data else{return}

            do{
                re = try JSONDecoder().decode([JeuExpose].self, from: data)
                DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                    self.jeuList.jeuListState = .loaded(re)
                }
                
                }catch{
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        self.jeuList.jeuListState = .loadingError(error)
                    }
                    print("Error: \(error)")
            }

        }.resume()
    }

}
