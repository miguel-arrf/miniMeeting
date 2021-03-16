//
//  miniSectionHeaderTest.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 04/03/2021.
//

import SwiftUI

struct miniCategoryHeader: View {
    
    @ObservedObject var category : CategoryViewModel
    var withDetailView: Bool = true
    var body: some View {
        
        HStack {
            Card(category: category, withDetailView: withDetailView)
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
        miniCategoryHeader(category: CategoryViewModel(category: Category(name: "Escola", backgroundColor: fixedColors[0], textColor: .white, emoji: fixedEmojis[0])))
    }
}

struct Card: View {
    
    @ObservedObject var category: CategoryViewModel
    var withDetailView: Bool
    
    var body: some View {
        HStack{
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(category.category.backgroundColor)
                .blendMode(.multiply)
                .frame(width: 30, height: 30)
                .overlay(
                    Text("\(category.category.emoji)")
                ).padding([.trailing]).padding(.leading, 20)
            
        
            
            Text("\(category.category.name)")
                .foregroundColor(category.category.textColor)
                .font(.title3)
                .fontWeight(.bold)
                .padding([.vertical])
            Spacer()
            
            if withDetailView{
                Image(systemName: "chevron.forward").foregroundColor(.white).padding()
            }
            
        }
//        .background(
//            VisualEffectView(effect: UIBlurEffect(style: .dark))
//                .clipShape(RoundedRectangle(cornerRadius: 20))
//                           .edgesIgnoringSafeArea(.all)
//        )
        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(category.category.backgroundColor).transition(.asymmetric(insertion: .scale, removal: .scale)))
        //.padding([.leading, .trailing])
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
