//
//  newContentView.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 05/03/2021.
//

import SwiftUI
import CoreHaptics

struct newContentView: View {
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    @ObservedObject var eventListViewModel = EventListViewModel()
    
    @State var selectedCategory: CategoryViewModel = CategoryViewModel(category: Category(name: "Escola", backgroundColor: fixedColors[0], textColor: .white, emoji: fixedEmojis[0]))
    
    @State var showDetailView: Bool = false
    @State var activeSheet: ActiveSheet?
    
    @ObservedObject var selectedCell = ObjectToSend()
    
    @State private var engine: CHHapticEngine?
    
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
                            
                        withAnimation{
                            miniCategoryHeader(category: categoryViewModel).padding([.leading, .trailing])
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
                
               
                
                miniEventFormView(eventCellViewModel: EventCellViewModel(event: Event(name: "", category: "", hasCategory : false, backgroundColor: fixedColors[0], textColor: .black)), multipleCategories: multipleCategories) { event in
                    
                    self.eventListViewModel.addEvent(event: event)
                }
                
            case .second:
                let copy = EventCellViewModel(
                    event: Event(
                        name: selectedCell.selectedCell.event.name,
                        category: selectedCell.selectedCell.event.category,
                        backgroundColor: selectedCell.selectedCell.event.backgroundColor,
                        textColor: selectedCell.selectedCell.event.textColor)
                )
                
                miniEventFormView(eventCellViewModel: copy, jaExiste: true, multipleCategories: multipleCategories){event in
                    selectedCell.selectedCell.event.name = event.name
                    selectedCell.selectedCell.event.category = event.category
                    selectedCell.selectedCell.event.backgroundColor = event.backgroundColor
                    selectedCell.selectedCell.event.textColor = event.textColor
                }
                
            case .third:
                miniCategoryFormView(categoryViewModel: CategoryViewModel(category: Category( name: "", backgroundColor: fixedColors[0], textColor: .black, emoji: fixedEmojis[0]))){ category in
                    self.eventListViewModel.addCategory(category: category)
                }
            }
        }
        
        .navigationBarItems(
            trailing:
                HStack {
                    
                    NavigationLink(destination: miniSettings()) {
                        Image(systemName: "gearshape")
                            .font(Font.system(.body).weight(.bold)).foregroundColor(Color("WhiteAndBlack"))
                    }
                    
                    Menu {
                        Button("Add Event", action: {
                            complexSuccess()
                            activeSheet = .first
                        })
                        
                        Button("Add Section", action: {
                            complexSuccess()
                            activeSheet = .third
                        })
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(Font.system(.body).weight(.bold)).foregroundColor(Color("WhiteAndBlack"))
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
                            .font(Font.system(.body).weight(.bold)).foregroundColor(Color("WhiteAndBlack"))
                    }
                    
                    
                    
                    
                })
        
        .navigationTitle("17 Fevereiro 2021")
        .onAppear(perform: prepareHaptics)
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
                                    let pasteboard = UIPasteboard.general
                                    pasteboard.string =  URL(string: event.event.link)?.absoluteString
                                }, label: {
                                    Label("Copy Link", systemImage: "doc.on.clipboard")
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
//                                        eventListViewModel.eventCellViewModels.removeAll{$0.event.id == event.event.id}
                                        
                                        EventRepository.shared.db.collection("events").document(event.event.id!).delete() { err in
                                            if let err = err {
                                                print("Error removing document: \(err)")
                                            } else {
                                                print("Document successfully removed!")
                                            }
                                        }
                                    }
                                        
                                        
    
                                        
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
