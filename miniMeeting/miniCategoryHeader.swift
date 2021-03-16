//
//  miniSectionHeaderTest.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 04/03/2021.
//

import SwiftUI

struct miniCategoryHeader: View {
    
    var category : Category
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
        miniCategoryHeader(category: Category(name: "Escola", backgroundColor: fixedColors[0].toSwiftUIColor, textColor: .white))
    }
}

struct Card: View {
    
    var category: Category
    var withDetailView: Bool
    
    var body: some View {
        HStack{
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(category.backgroundColor)
                .blendMode(.multiply)
                .frame(width: 30, height: 30)
                .overlay(
                    Text("🤩")
                ).padding([.trailing]).padding(.leading, 20)
            
        
            
            Text("\(category.name)")
                .foregroundColor(category.textColor)
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
        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(category.backgroundColor).opacity(1).transition(.asymmetric(insertion: .scale, removal: .scale)))
        .padding([.leading, .trailing])
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
