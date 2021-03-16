//
//  EventCellViewModel.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 18/02/2021.
//

import Foundation
import Combine

class EventCellViewModel: ObservableObject, Identifiable {
    
    
    @Published var event: Event
        
    var id = UUID().uuidString
    
    private var cancellables = Set<AnyCancellable>()
    
    init(event: Event) {
        self.event = event
        
        $event
            .compactMap{event in
                event.id
            }
            .assign(to: \.id, on:self)
            .store(in: &cancellables)
        
        $event
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink{ event in
                EventRepository.shared.updateEvent(event)
            }
            .store(in: &cancellables)
    }
    
}
