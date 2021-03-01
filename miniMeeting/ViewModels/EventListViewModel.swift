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
    @Published var categoryViewModels = [CategoryViewModel]()
    
    private var cancellablesEvents = Set<AnyCancellable>()
    private var cancellablesCategories = Set<AnyCancellable>()

    
    init() {
        
        CategoryRepository.shared.$categories.map{ categories in
            categories.map{ category in
                CategoryViewModel(category: category)
            }
        }.assign(to: \.categoryViewModels, on:self)
        .store(in: &cancellablesCategories)
        
        EventRepository.shared.$events.map{ events in
            events.map{ event in
                EventCellViewModel(event: event)
            }
        }.assign(to: \.eventCellViewModels, on:self)
        .store(in: &cancellablesEvents)
        
        
       
        
    }
    
    func addEvent(event: Event) {
        EventRepository.shared.addEvent(event)
//        let eventViewModel = EventCellViewModel(event: event)
//        self.eventCellViewModels.append(eventViewModel)
        
    }
    
    func addCategory(category: Category){
        CategoryRepository.shared.addCategory(category)
    }
    

}
