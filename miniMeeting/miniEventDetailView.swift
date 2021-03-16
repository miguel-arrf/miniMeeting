//
//  miniEventDetailView.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 27/02/2021.
//

import SwiftUI

struct miniEventDetailView: View {
    
    var event:Event
    
    var body: some View {
        VStack {
            
            VStack{
                Text(event.name)
                    .fontWeight(.bold)
                    .foregroundColor(event.textColor)
                    .padding(.bottom, 10)
                
            }.padding().frame(maxWidth:.infinity)
            .background(event.backgroundColor.opacity(0.3).clipShape(RoundedRectangle(cornerRadius:20)))
            .contentShape(RoundedRectangle(cornerRadius: 19, style: .continuous))
            .padding([.top, .leading, .trailing])
            
            if (event.link != nil) {
                VStack{
                    Button(action: {
                        //UIApplication.shared.open(event.link!)
                    }, label: {
                        HStack{
                            Image(systemName: "link")
                            Text("\(event.link)")
                        }
                    })
                    
                }.padding().frame(maxWidth:.infinity)
                .background(event.backgroundColor.opacity(0.3).clipShape(RoundedRectangle(cornerRadius:20)))
                .contentShape(RoundedRectangle(cornerRadius: 19, style: .continuous))
                .padding()
            }
            
            Spacer()
            
        }.navigationTitle(event.name)
    }
}

struct miniEventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            miniEventDetailView(event:  Event( name: "PISID - Teórica", category: "Favorites", backgroundColor: UIColor(red: 252/255, green: 227/255, blue: 138/255, alpha: 1).toSwiftUIColor, textColor: UIColor(red: 218/255, green: 115/255, blue: 60/255, alpha: 1).toSwiftUIColor))
        }
    }
}
