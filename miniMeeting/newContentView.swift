//
//  newContentView.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 05/03/2021.
//

import SwiftUI

struct newContentView: View {
    
    @ObservedObject var eventListViewModel = EventListViewModel()
    
    @State var selectedCategory: CategoryViewModel = CategoryViewModel(category: Category(name: "Escola", backgroundColor: fixedColors[0].toSwiftUIColor, textColor: .white))
    
    @State var showDetailView: Bool = false
    @State var activeSheet: ActiveSheet?
    
    @ObservedObject var selectedCell = ObjectToSend()
    
    init() {
        /*UINavigationBar.appearance().largeTitleTextAttributes =
            [.font: UIFont(descriptor:
                            UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
                            .withDesign(.serif)!, size: 30)]*/
        
        self.eventListViewModel = EventListViewModel()
    }
    
    var body: some View {
        
        ScrollView{
            
            Rectangle().opacity(0)
            
            
            
            VStack(spacing: 0){
                
                NavigationLink(destination: miniCategoryDetailView(categoryViewModel: selectedCategory, eventListViewModel: eventListViewModel), isActive: $showDetailView) {
                    EmptyView()
                }
                
                HStack {
                    Text("Groups").font(.title2).fontWeight(.bold).padding()
                    Spacer()
                }
                
                LazyVStack(spacing: 20) {
                    ForEach(eventListViewModel.categoryViewModels){categoryViewModel in
                        let category = categoryViewModel.category
                            
                        withAnimation{
                            miniCategoryHeader(category: category)
                                .onTapGesture {
                                    selectedCategory = categoryViewModel
                                    showDetailView.toggle()
                                }
                        }
                           

                    }
                }
                
            }

            
            Rectangle().opacity(0)
            
            HStack {
                Text("Meetings").font(.title2).fontWeight(.bold).padding()
                Spacer()
            }
            
            NoCategoryCards(eventListViewModel: eventListViewModel, activeSheet: $activeSheet, selectedCell: selectedCell)
            
        }
        
        .sheet(item: $activeSheet) { item in
            
            let multipleCategories = eventListViewModel.categoryViewModels.map{ categoryCell -> String in
                if categoryCell.category.name.isEmpty{
                    return "Default category"
                }else{
                    return categoryCell.category.name
                }
                
            }
            
            switch item {
            case .first:
                miniEventFormView(eventCellViewModel: EventCellViewModel(event: Event(name: "", category: "", date: Date(), fromHour: Date(), toHour: Date(), backgroundColor: Color.black.opacity(0.3), textColor: .black)), multipleCategories: multipleCategories) { event in
                    
                    self.eventListViewModel.addEvent(event: event)
                }
                
            case .second:
                let copy = EventCellViewModel(
                    event: Event(
                        name: selectedCell.selectedCell.event.name,
                        category: selectedCell.selectedCell.event.category,
                        date : selectedCell.selectedCell.event.date,
                        fromHour: selectedCell.selectedCell.event.fromHour,
                        toHour: selectedCell.selectedCell.event.toHour, backgroundColor: selectedCell.selectedCell.event.backgroundColor,
                        textColor: selectedCell.selectedCell.event.textColor)
                )
                
                miniEventFormView(eventCellViewModel: copy, jaExiste: true, multipleCategories: multipleCategories){event in
                    selectedCell.selectedCell.event.name = event.name
                    selectedCell.selectedCell.event.category = event.category
                    selectedCell.selectedCell.event.backgroundColor = event.backgroundColor
                    selectedCell.selectedCell.event.textColor = event.textColor
                    selectedCell.selectedCell.event.date = event.date
                    selectedCell.selectedCell.event.fromHour = event.fromHour
                    selectedCell.selectedCell.event.toHour = event.toHour
                    
                }
                
            case .third:
                miniCategoryFormView(categoryViewModel: CategoryViewModel(category: Category( name: "New Category", backgroundColor: .orange, textColor: .blue))){ category in
                    self.eventListViewModel.addCategory(category: category)
                }
            }
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
                            activeSheet = .first
                        })
                        Button("Add Section", action: {
                            activeSheet = .third
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
    @Binding var activeSheet: ActiveSheet?
    @ObservedObject var selectedCell : ObjectToSend
    
    var body: some View {
        ZStack{
            LazyVStack(spacing: 20){
                
                ForEach(eventListViewModel.eventCellViewModels){ event in
                   
                    
                    if event.event.hasCategory == false {
                        withAnimation{
                            VStack{
                            miniCard(eventCellViewModel: event)
                         
                                .padding([.leading, .trailing])
                            }.contextMenu(ContextMenu(menuItems: {
                                
                                Button(action: {
                                    yupiNotification(for: event.event)
                                }, label: {
                                    Label("Turn On notification", systemImage: "bell")
                                })
                                
                                Button(action: {
                                    selectedCell.changeCell(event)
                                    activeSheet = .second
                                }, label: {
                                    Label("Edit", systemImage: "slider.horizontal.3")
                                })
                                
                                Button(action: {
                                    

                                        //eventListViewModel.addEvent(event: event)
                                        /*withAnimation{
                                            eventListViewModel.removeEvent(event: event.event)
                                        }*/

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                                        eventListViewModel.eventCellViewModels.removeAll{$0.event.id == event.event.id}
                                    }
                                        
                                        /*EventRepository.shared.db.collection("events").document(event.event.id!).delete() { err in
                                            if let err = err {
                                                print("Error removing document: \(err)")
                                            } else {
                                                print("Document successfully removed!")
                                            }
                                        }*/
    
                                        
                                }, label: {
                                    Label("Delete", systemImage: "trash")
                                })
                            }))
                        }
                    }
                }
                
            }.animation(.spring(), value: eventListViewModel.eventCellViewModels)
        }
    }
    
}
