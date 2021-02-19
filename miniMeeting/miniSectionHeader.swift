//
//  miniSectionHeader.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 19/02/2021.
//

import SwiftUI

struct miniSectionHeader: View {
    
    var event:(String, Color, Color)
    
    var body: some View {
        HStack {
                        Text(event.0)
                            .fontWeight(.bold).foregroundColor(event.1)
                        
                        ZStack {
                            Text("1").font(.footnote).fontWeight(.bold).foregroundColor(event.2)
                            RoundedRectangle(cornerRadius: 5).frame(width:25, height:25).foregroundColor(event.1.opacity(0.3))
                        }
                        
                       
                        
                        Spacer()
                        Image(systemName: "chevron.up")
                            .font(Font.system(.body).weight(.semibold)).foregroundColor(event.2)
                    }.padding([.leading, .trailing])
    }
}

struct miniSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        miniSectionHeader(event: (testDataEvents[0].name,testDataEvents[0].backgroundColor, testDataEvents[0].textColor ))
    }
}
