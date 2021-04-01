//
//  SearchZoneListViewIntent.swift
//  festival-jeu
//
//  Created by ayoub moujane on 01/04/2021.
//

import Foundation
import SwiftUI



class SearchZoneListViewIntent{
    
    @ObservedObject var zoneList : SearchZoneListViewModel
    
    init(zoneList: SearchZoneListViewModel){
        self.zoneList = zoneList
    }
        
    func loaded(zones: [Zone]){
        #if DEBUG
        debugPrint("SearchIntent: \(self.zoneList.zoneListState) => \(zones.count) tracks loaded")
        #endif
        self.zoneList.zoneListState = .ready
    }
    
    func httpJsonLoaded(result: Result<[Zone], HttpRequestError>){
        switch result {
        case let .success(data):
            #if DEBUG
            debugPrint("SearchIntent: httpJsonLoaded -> success -> .loaded(tracks)")
            #endif
            zoneList.zoneListState = .loaded(data)
        case let .failure(error):
            zoneList.zoneListState = .loadingError(error)
        }
    }
    
    func zoneLoaded(){
        #if DEBUG
        debugPrint("SearchIntent: track deleted => save data")
        #endif
        zoneList.zoneListState = .ready
    }

    var artistFilter : String? = nil

    func loadZones(url : String, artistFilter: String?){
        self.artistFilter = artistFilter
        #if DEBUG
        debugPrint("SearchIntent: .loading(\(url))")
        debugPrint("SearchIntent: asyncLoadTracks")
        #endif
        zoneList.zoneListState = .loading(url)
//        ITunesTrackHelper.loadTracksFromAPI(url: url, endofrequest: httpJsonLoaded)
    }
    
    func loadData() {
        
        var re = [Zone]()

        
        zoneList.zoneListState = .loading("http://localhost:8080/api/zones/custom/courant")
        let surl = "http://localhost:8080/api/zones/custom/courant"
        guard let url = URL(string: surl) else { print("rien"); return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data,response,error in
            guard let data = data else{return}

            do{
                re = try JSONDecoder().decode([Zone].self, from: data)
                print("Nombre de zones récupérées : \(re.count)")
                DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                    self.zoneList.zoneListState = .loaded(re)
                }
                
            }catch{
                DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                    self.zoneList.zoneListState = .loadingError(error)
                }
                print("Error: \(error)")
            }

        }.resume()
    }

}
