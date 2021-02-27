//
//  CategoryViewModel.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 27/02/2021.
//

import Foundation
import Combine

class CategoryViewModel: ObservableObject, Identifiable {
    
    
    @Published var category: Category
        
    var id: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(category: Category) {
        self.category = category
        
        $category
            .compactMap{event in
                event.id
            }
            .assign(to: \.id, on:self)
            .store(in: &cancellables)
        
        $category
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink{ event in
                CategoryRepository.shared.updateCategory(category)
            }
            .store(in: &cancellables)
    }
    
}
