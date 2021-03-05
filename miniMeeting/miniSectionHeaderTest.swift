//
//  miniSectionHeaderTest.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 04/03/2021.
//

import SwiftUI

struct miniSectionHeaderTest: View {
    
    var category : Category
    
    var body: some View {
        
        HStack {
            Card(category: category)
                .contextMenu(ContextMenu(menuItems: {
                    
                    Button(action: {
                        
                    }, label: {
                        Label("Edit", systemImage: "slider.horizontal.3")
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Label("Remove", systemImage: "trash")
                    })
                    
                }))
        }
        
        
    }
}

struct miniSectionHeaderTest_Previews: PreviewProvider {
    static var previews: some View {
        miniSectionHeaderTest(category: Category(name: "Escola", backgroundColor: fixedColors[0].toSwiftUIColor, textColor: .white))
    }
}

struct Card: View {
    
    var category: Category
    
    var body: some View {
        HStack{
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(category.backgroundColor)
                .blendMode(.multiply)
                .frame(width: 40, height: 40).overlay(
                    Text("🤩")
                ).padding([.bottom, .trailing, .top]).padding(.leading, 20)
            
            
            
            Text("\(category.name)")
                .foregroundColor(category.textColor)
                .font(.title3)
                .fontWeight(.bold)
                .padding([.top, .bottom])
            Spacer()
        }
        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(category.backgroundColor).opacity(1).transition(.asymmetric(insertion: .scale, removal: .scale))).padding([.leading, .trailing])
    }
}
