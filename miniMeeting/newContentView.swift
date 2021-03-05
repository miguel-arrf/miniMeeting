//
//  newContentView.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 05/03/2021.
//

import SwiftUI

struct newContentView: View {
    
    @ObservedObject var eventListViewModel = EventListViewModel()
    
    var body: some View {
        
        ScrollView{
            
            Rectangle().opacity(0)

            HStack {
                Text("Groups").font(.title2).fontWeight(.bold).padding()
                Spacer()
            }
            
            VStack(spacing: 20){
                
                
                ForEach(eventListViewModel.categoryViewModels){categoryViewModel in
                    let category = categoryViewModel.category
                    
                    miniCategoryHeader(category: category)
                    
                }
                
            }
            
            Rectangle().opacity(0)
            
            HStack {
                Text("Meetings").font(.title2).fontWeight(.bold).padding()
                Spacer()
            }
            
            NoCategoryCards(eventListViewModel: eventListViewModel)
            
        }
        
        .navigationBarItems(
            trailing:
                HStack {
                    
                    NavigationLink(destination: miniSettings()) {
                        Image(systemName: "gearshape")
                            .font(Font.system(.body).weight(.bold)).foregroundColor(.black)
                    }
                    
                    Menu {
                        Button("Add Event", action: {
                        })
                        Button("Add Section", action: {
                        })
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(Font.system(.body).weight(.bold)).foregroundColor(.black)
                    }
                    
                    Menu {
                        
                        Section{
                            Button("Edit Sections", action: {})
                        }
                        
                        Section{
                            Button("Disable sections", action: {})
                        }
                        
                        Button("Order by number", action: placeOrder)
                        Button("Order by + recent", action: adjustOrder)
                        Button("Order by - recent", action: placeOrder)
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(Font.system(.body).weight(.bold)).foregroundColor(.black)
                    }
                    
                    
                    
                    
                })
        
        .navigationTitle("17 Fevereiro 2021")
        
        
        
    }
}

struct newContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            newContentView()
        }
    }
}

struct NoCategoryCards: View {
    
    @ObservedObject var eventListViewModel:EventListViewModel
    
    var body: some View {
        ZStack{
            VStack(spacing: 20){
                ForEach(eventListViewModel.eventCellViewModels){ event in
                    if event.event.hasCategory == false {
                        withAnimation{
                            miniCard(eventCellViewModel: event)
                                .padding([.leading, .trailing])
                                .transition(.move(edge: .leading))
                        }
                    }
                }
            }
        }
    }
    
}
