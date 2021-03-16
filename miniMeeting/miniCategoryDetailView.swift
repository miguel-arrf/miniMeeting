//
//  miniCategoryDetailView.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 05/03/2021.
//

import SwiftUI

struct miniCategoryDetailView: View {
    
    var categoryViewModel: CategoryViewModel
    @ObservedObject var eventListViewModel: EventListViewModel
    @State var activeSheet: ActiveSheet?

    
    var body: some View {
        
        ScrollView{
            
//            GeometryReader { geometry in
//                ZStack(alignment: .bottom) {
//                    if geometry.frame(in: .global).minY <= 0 {
//                        Rectangle()
//                            .foregroundColor(categoryViewModel.category.backgroundColor)
//                            .frame(width: geometry.size.width, height: geometry.size.height)
//                            .offset(y: geometry.frame(in: .global).minY)
//                            .clipped()
//                        
//                        miniCategoryHeader(category: categoryViewModel.category, withDetailView: false)
//                            .blendMode(.exclusion)
//                            .padding(.bottom, 25)
//                            .offset(y: geometry.frame(in: .global).minY)
//                    } else {
//                        Rectangle()
//                            .foregroundColor(categoryViewModel.category.backgroundColor)
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
//                            .clipped()
//                            .offset(y: -geometry.frame(in: .global).minY)
//                        
//                        miniCategoryHeader(category: categoryViewModel.category, withDetailView: false)
//                            .blendMode(.exclusion)
//                            .padding(.bottom, 25)
//                            .offset(y: -geometry.frame(in: .global).minY)
//                        
//                    }
//                    
//                    
//                }
//            }
//            .frame(height: 100)
            
            VStack {
                
                ForEach(eventListViewModel.eventCellViewModels.filter {$0.event.category == categoryViewModel.category.name }){eventCellViewModel in
                    miniCard(eventCellViewModel: eventCellViewModel)
                        .padding()
                    
                }
                
                Spacer()
                
            }
        }
        .sheet(item: $activeSheet) { item in
            
            let multipleCategories = eventListViewModel.categoryViewModels.map{ categoryCell -> String in
                if categoryCell.category.name.isEmpty{
                    return "Default category"
                }else{
                    return categoryCell.category.name
                }
                
            }
            
            
            if item == .first {
                miniEventFormView(eventCellViewModel: EventCellViewModel(event: Event(name: "", category: "", backgroundColor: Color.black.opacity(0.3), textColor: .black)), multipleCategories: multipleCategories) { event in
                    
                    self.eventListViewModel.addEvent(event: event)
                }
            }
           

            
        }

        
        .navigationBarItems(
            trailing:
                HStack {
                    
                    Button(action: {
                        activeSheet = .first
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(Font.system(.body).weight(.bold)).foregroundColor(.black)
                        
                    })
                    
                })
        
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(categoryViewModel.category.name)
        
    }
}

struct miniCategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            miniCategoryDetailView(categoryViewModel: CategoryViewModel(category: Category(name: "Escola", backgroundColor: fixedColors[0], textColor: .white, emoji: fixedEmojis[0])), eventListViewModel: EventListViewModel())
        }
        
    }
}
