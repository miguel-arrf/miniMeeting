//
//  ContentView.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 18/02/2021.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case first, second
    
    var id: Int {
        hashValue
    }
}

class ObjectToSend : ObservableObject{
    @Published var selectedCell : EventCellViewModel = EventCellViewModel(event: Event(name: "", category: "teste", date: Date(), fromHour: Date(), toHour: Date(), backgroundColor: .blue, textColor: .black))
    
    func changeCell(_ event: EventCellViewModel) {
        selectedCell = event
    }
}

class OpenedSections: ObservableObject {
    @Published var openedSection : [Bool] = [Bool]()
}

struct ContentView: View {
    
    @State var presentANewItem = false
    @State var showingEdit = false
    @State var activeSheet: ActiveSheet?
    
    @ObservedObject var eventListViewModel = EventListViewModel()
    @ObservedObject var selectedCell = ObjectToSend()
    
    @State var testecoiso = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes =
            [.font: UIFont(descriptor:
                            UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
                            .withDesign(.serif)!, size: 30)]
    }
    
    var body: some View {
        ZStack(alignment:.bottomTrailing){
            
            ScrollView{
                Rectangle().frame(width: 10, height: 10).foregroundColor(.clear)
                let multipleCategories = eventListViewModel.eventCellViewModels.map{ (eventCell) -> (String, Color, Color) in
                    return (eventCell.event.category, eventCell.event.backgroundColor, eventCell.event.textColor)
                }
                
                ForEach(removeDuplicates(multipleCategories), id: \.0){category in
                    
                    miniSectionHeader(event: category, count: getCount(category.0, eventListViewModel), category: category, eventListViewModel: eventListViewModel,activeSheet: $activeSheet, selectedCell: selectedCell)
                    
//                    if(!testecoiso){
//
////                        ForEach(eventListViewModel.eventCellViewModels.filter {$0.event.category == category.0 }){eventCellViewModel in
////
////                            miniCard(eventCellViewModel: eventCellViewModel)
////                                .contextMenu(ContextMenu(menuItems: {
////                                    Button(action: {
////                                        selectedCell.changeCell(eventCellViewModel)
////                                        activeSheet = .second
////                                    }, label: {
////                                        Label("Edit", systemImage: "slider.horizontal.3")
////                                    })
////
////                                    Button(action: {
////
////                                        EventRepository.shared.db.collection("events").document(eventCellViewModel.event.id!).delete() { err in
////
////                                            if let err = err {
////                                                print("Error removing document: \(err)")
////                                            } else {
////                                                print("Document successfully removed!")
////                                            }
////
////                                        }
////
////                                    }, label: {
////                                        Label("Delete", systemImage: "trash")
////                                    })
////                                }))
////                                .transition(.asymmetric(insertion: .scale, removal: .opacity))
////                        }
//
//                    }
                    
                }
                
            }
//            .padding([.top])
            
        }
        
        .sheet(item: $activeSheet) { item in
            
            let multipleCategories = eventListViewModel.eventCellViewModels.map{ (eventCell) -> String in
                return eventCell.event.category
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
                }
                
            }
        }
        
        
        .navigationBarItems( trailing:
                                HStack {
                                    
                                    NavigationLink(destination: miniSettings()) {
                                        Image(systemName: "gearshape")
                                            .font(Font.system(.body).weight(.bold)).foregroundColor(.black)
                                    }
                                    
                                    
//                                    Button(action: {
//                                        activeSheet = .first
//                                    }) {
//
//                                        Image(systemName: "gearshape")
//                                            .font(Font.system(.body).weight(.bold)).foregroundColor(.black)
//
//                                    }.foregroundColor(.black)
                                    
                                    Button(action: {
                                        activeSheet = .first
                                    }) {
                                        Image(systemName: "plus")
                                            .font(Font.system(.body).weight(.bold)).foregroundColor(.black)
                                    }.foregroundColor(.black)
                                    
                                })
        
        .navigationTitle("17 Fevereiro 2021")
    }
}

func getCount(_ category : String, _ eventListViewModel : EventListViewModel) -> Int {
    
    let count = eventListViewModel.eventCellViewModels.filter{ cell in
        return cell.event.category == category
    }
    
    
    return count.count
}

func removeDuplicates(_ list: [(String, Color, Color)]) -> [(String, Color, Color)] {
    
    var newList = [(String, Color, Color)]()
    
    for item in list {
        if newList.firstIndex(where: { (currentItem) -> Bool in
            currentItem.0 == item.0
        }) == nil{
            newList.append(item)
        }
    }
    
    return newList
}

func listToString(_ multipleCategories : [(String, Color, Color)]) -> String {
    
    var string = ""
    
    for element in multipleCategories{
        string += element.0 + " "
    }
    return string
}

extension String: Identifiable {
    public var id: String {
        return self
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContentView()
        }
        .preferredColorScheme(.light)
    }
}
