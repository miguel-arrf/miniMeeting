//
//  ContentView.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 18/02/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var eventListViewModel = EventListViewModel()
    
    @State var presentANewItem = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes =
            [.font: UIFont(descriptor:
                            UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
                            .withDesign(.serif)!, size: 24)]
    }
    
    var body: some View {
        ZStack(alignment:.bottomTrailing){
            
            ScrollView{
                let multipleCategories = eventListViewModel.eventCellViewModels.map{ (eventCell) -> (String, Color, Color) in
                    return (eventCell.event.category, eventCell.event.backgroundColor, eventCell.event.textColor)
                }
                                
                ForEach(removeDuplicates(multipleCategories), id: \.0){category in
                    
                    Text(category.0)
                    miniSectionHeader(event: category)

                    ForEach(eventListViewModel.eventCellViewModels.filter {$0.event.category == category.0 }){eventCellViewModel in
                        miniCard(eventCellViewModel: eventCellViewModel)

                    }
                    
                }
                
            }
            
        }.sheet(isPresented: $presentANewItem) {
            miniEventFormView(eventCellViewModel: EventCellViewModel(event: Event(name: "Empty", fromHour: 0, toHour: 0, category: "", backgroundColor: Color.black.opacity(0.3), textColor: .black))) { event in
                
                self.eventListViewModel.addEvent(event: event)
                
            }
            
            
        }
        .toolbar(content: {
            ToolbarItem(placement: .primaryAction) {
                
                
                Image(systemName:"plus").font(Font.system(.body).weight(.bold)).foregroundColor(.black).padding(.trailing, 30)
                    .onTapGesture {
                        withAnimation{
                            self.presentANewItem.toggle()
                        }
                    }
            }
            
        })
        .navigationTitle("17 Fevereiro 2021")
    }
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
    }
}
