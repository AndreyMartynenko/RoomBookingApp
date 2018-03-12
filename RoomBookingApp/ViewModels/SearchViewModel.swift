//
//  SearchViewModel.swift
//  RoomBookingApp
//
//  Created by Andrey on 3/11/18.
//

import Foundation

protocol SearchViewModelDelegate: class {
    
    func onRoomsUpdated()
    func onError(error: NetworkError)
    
}

class SearchViewModel: NSObject {
    
    fileprivate weak var delegate: SearchViewModelDelegate?
    fileprivate var items: [Room]
    fileprivate var filteredItems: [Room]
    fileprivate let client: SearchClient
    fileprivate var isFilterApplied: Bool
    
    init(delegate: SearchViewModelDelegate) {
        self.delegate = delegate
        items = []
        filteredItems = []
        client = SearchClient()
        isFilterApplied = false
        
        super.init()
    }
    
    func start() {
        
    }
    
    func stop() {
        
    }
    
    var itemsCount: Int {
        get {
            return isFilterApplied ? filteredItems.count : items.count
        }
    }
    
    func item(at index: Int) -> Room {
        return isFilterApplied ? filteredItems[index] : items[index]
    }
    
    func itemPressed(at index: Int) {
        
    }
    
    func filter(name: String) {
        if name.isEmpty {
            isFilterApplied = false
            delegate?.onRoomsUpdated()
            return
        }
        
        isFilterApplied = true
        filteredItems = items.filter( { $0.name != nil && $0.name!.contains(name.lowercased()) } )
        delegate?.onRoomsUpdated()
    }
    
    func filter(availability: Bool) {
        if availability == false {
            isFilterApplied = false
            delegate?.onRoomsUpdated()
            return
        }
        
        // TODO: apply proper filter
        isFilterApplied = true
        delegate?.onRoomsUpdated()
    }
    
    func fetchRooms(date: Date) {
        client.retrieveRooms(with: configuredParameters(date: date)) { [weak self] (result) in
            switch result {
            case .success(let rooms):
                if let rooms = rooms {
                    self?.items = rooms
                    self?.delegate?.onRoomsUpdated()
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self?.delegate?.onError(error: error)
            }
        }
    }
    
    fileprivate func configuredParameters(date: Date) -> Any? {
        let timestamp = String(format: "%.0f", date.timeIntervalSince1970.rounded())

        return ["date" : timestamp]
    }
    
}
