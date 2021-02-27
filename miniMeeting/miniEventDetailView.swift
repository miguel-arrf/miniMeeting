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
                HStack{
                    Text(formatHour(event.fromHour)).fontWeight(.bold).foregroundColor(event.backgroundColor)
                    
                    Image(systemName: "arrow.right")
                        .font(Font.system(.footnote).weight(.heavy)).foregroundColor(event.textColor)
                    
                    Text(formatHour(event.toHour)).fontWeight(.bold).foregroundColor(event.backgroundColor)
                }.frame(minWidth:80).padding(3).padding([.leading,.trailing],10).background(
                    Color.white
                        .clipShape(RoundedRectangle(cornerRadius:20))
                )
                
            }.padding().frame(maxWidth:.infinity)
            .background(event.backgroundColor.opacity(0.3).clipShape(RoundedRectangle(cornerRadius:20)))
            .contentShape(RoundedRectangle(cornerRadius: 19, style: .continuous))
            .padding([.top, .leading, .trailing])
            
            if (event.link != nil) {
                VStack{
                    Button(action: {
                        UIApplication.shared.open(event.link!)
                    }, label: {
                        HStack{
                            Image(systemName: "link")
                            Text("\(event.link!)")
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
            miniEventDetailView(event:  Event( name: "PISID - Teórica", category: "Favorites", date: Date(), fromHour: Date(), toHour: Date(), backgroundColor: UIColor(red: 252/255, green: 227/255, blue: 138/255, alpha: 1).toSwiftUIColor, textColor: UIColor(red: 218/255, green: 115/255, blue: 60/255, alpha: 1).toSwiftUIColor, link: URL(string: "www.google.pt")))
        }
    }
}
