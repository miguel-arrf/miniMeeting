//
//  EventListViewModel.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 18/02/2021.
//

import Foundation
import Combine
import SwiftUI

class EventListViewModel: ObservableObject {
    @Published var eventCellViewModels = [EventCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
        EventRepository.shared.$events.map{ events in
            events.map{ event in
                EventCellViewModel(event: event)
            }
        }.assign(to: \.eventCellViewModels, on:self)
        .store(in: &cancellables)
        
    }
    
    func addEvent(event: Event) {
        EventRepository.shared.addEvent(event)
//        let eventViewModel = EventCellViewModel(event: event)
//        self.eventCellViewModels.append(eventViewModel)
        
    }
    

}
