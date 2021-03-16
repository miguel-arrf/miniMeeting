//
//  miniCategoryView.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 01/03/2021.
//

import SwiftUI

struct miniCategoryView: View {
    
    @ObservedObject var eventListViewModel = EventListViewModel()
    @State var activeSheet: ActiveSheet?
    
    
    var body: some View {
        VStack{
            ForEach(eventListViewModel.categoryViewModels){category in
                miniCategory(categoryViewModel: category)
            }
            
            Spacer()
            
        }
        .sheet(item: $activeSheet){ item in
            switch item{
            case .first:
                Text("hehe - 1")
            case .second:
                Text("hehe - 2")
                
            case .third:
                miniCategoryFormView(categoryViewModel: CategoryViewModel(category: Category( name: "New Category", backgroundColor: .orange, textColor: .blue, emoji: fixedEmojis[0]))){ category in
                    self.eventListViewModel.addCategory(category: category)
                }
            }
            
        }
        .navigationBarItems(trailing: Image(systemName: "plus"))
        .navigationBarTitle("Tags")
        
        
        
    }
    
    
    func onAdd() {
        activeSheet = .third
    }
    
    
}

struct miniCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            miniCategoryView()
        }
    }
}

struct miniCategory: View {
    
    var categoryViewModel: CategoryViewModel
    
    var body: some View {
        
        
        //        Text(categoryViewModel.category.name).fontWeight(.bold).foregroundColor(categoryViewModel.category.textColor).padding([.top, .bottom], 6).padding([.leading, .trailing], 6)
        //            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(categoryViewModel.category.backgroundColor).opacity(0.1))
        //            .padding([.top,.bottom], 6)
        
        
        HStack{
            Text(categoryViewModel.category.name)
                .fontWeight(.bold)
                .foregroundColor(categoryViewModel.category.textColor)
            
            Spacer()
            
        }.padding().frame(maxWidth:.infinity)
        .background(categoryViewModel.category.backgroundColor.opacity(0.3).clipShape(RoundedRectangle(cornerRadius:20)))
        
        
        .contentShape(RoundedRectangle(cornerRadius: 19, style: .continuous))
        .padding()
        
        
    }
}




