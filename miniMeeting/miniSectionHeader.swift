//
//  miniSectionHeader.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 19/02/2021.
//

import SwiftUI
import UserNotifications

struct miniSectionHeader: View {
    
    var event:(String, Color, Color)
    var count :Int = 1
    
    @State var openedSection : Bool = true
    
    @Binding var editing : Bool
    @State var selected: Bool = false
    
    var category : (String, Color, Color)
    @ObservedObject var eventListViewModel: EventListViewModel
    @Binding var activeSheet: ActiveSheet?
    @ObservedObject var selectedCell : ObjectToSend
    
    func turnOff(){
        openedSection = false
    }
    
    var body: some View {
        VStack{
            HStack {
                
                Group{
                    Text(event.0)
                        .fontWeight(.bold).foregroundColor(event.1)
                    
                    ZStack {
                        Text(String(count)).font(.footnote).fontWeight(.bold).foregroundColor(event.2)
                        RoundedRectangle(cornerRadius: 5).frame(width:25, height:25).foregroundColor(
                            event.1.opacity(0.3)
                        )
                    }
                    
                    if count == 0{
                        Text("Empty").fontWeight(.bold).foregroundColor(.gray)
                    }
                }.opacity(openedSection ? 1 : 0.5)
                .animation(.easeInOut)
                
                
                Spacer()
                
                if count != 0{
                    Image(systemName: "chevron.up")
                        .font(Font.system(.body).weight(.semibold)).foregroundColor(event.2)
                        .onTapGesture {
                            withAnimation{
                                openedSection.toggle()
                            }
                        }
                        .rotationEffect(Angle.degrees(openedSection ? 0 : 180))
                        .animation(.easeInOut)
                        .opacity(openedSection ? 1 : 0.5)
                    
                }
                
                if editing{
                    ZStack{
                        Circle().foregroundColor(.red).opacity(0.2).offset(x: editing ? 0 : 50).frame(width: 20, height: 20)
                            .onTapGesture {
                                withAnimation{
                                        selected.toggle()
                                }
                            }
                           
                        Image(systemName: "checkmark.circle").opacity(selected ? 1 : 0).foregroundColor(.red)
                            .onTapGesture {
                                withAnimation{
                                    selected.toggle()
                                }
                        }
                    }
                    
                }
                

            }.padding([.leading, .trailing])
            
            
            if(openedSection){
                ForEach(eventListViewModel.eventCellViewModels.filter {$0.event.category == category.0 }){eventCellViewModel in
                    
                    miniCard(eventCellViewModel: eventCellViewModel)
                        .contextMenu(ContextMenu(menuItems: {
                            
                            Button(action: {
                                yupiNotification(for: eventCellViewModel.event)
                            }, label: {
                                Label("Turn On notification", systemImage: "bell")
                            })
                            
                            Button(action: {
                                selectedCell.changeCell(eventCellViewModel)
                                activeSheet = .second
                            }, label: {
                                Label("Edit", systemImage: "slider.horizontal.3")
                            })
                            
                            Button(action: {
                                
                                EventRepository.shared.db.collection("events").document(eventCellViewModel.event.id!).delete() { err in
                                    
                                    if let err = err {
                                        print("Error removing document: \(err)")
                                    } else {
                                        print("Document successfully removed!")
                                    }
                                    
                                }
                                
                            }, label: {
                                Label("Delete", systemImage: "trash")
                            })
                        })).padding([.leading, .trailing])
                        //                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
            }
    
        }
        .overlay(RoundedRectangle(cornerRadius: 20).foregroundColor(category.2).opacity(0.05).padding().offset(y: 15).transition(.asymmetric(insertion: .scale, removal: .slide)))
   
    }
}

func yupiNotification(for event: Event) {
    addNotification(for: event)
}

func getNotification(for event: Event, for center: UNUserNotificationCenter, for number: NSNumber){
    
     
    
}

func addNotification(for event: Event, number: NSNumber? = 0){
    let center = UNUserNotificationCenter.current()
    
    
    
    center.getNotificationSettings{ settings in
        if settings.authorizationStatus == .authorized{

            let badgeCount = UserDefaults.standard.value(forKey: "NotificationBadgeCount") as! Int + 1
            UserDefaults.standard.setValue(badgeCount, forKey: "NotificationBadgeCount")
            getNotification(for: event, for: center, for: badgeCount as NSNumber)

            
        } else {
            center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success{
                    let badgeCount = UserDefaults.standard.value(forKey: "NotificationBadgeCount") as! Int + 1
                    UserDefaults.standard.setValue(badgeCount, forKey: "NotificationBadgeCount")
                    getNotification(for: event, for: center, for: badgeCount as NSNumber)
//                    UIApplication.shared.applicationIconBadgeNumber = 2
                }else {
                    print("D'oh")
                }
                
            }
        }
    }
    
    
}

#if DEBUG
struct miniSectionHeader_Previews : PreviewProvider {
    
    @State static var activeSheet : ActiveSheet? = ActiveSheet.first
    
    static var previews: some View {
        miniSectionHeader(event: (testDataEvents[0].name,testDataEvents[0].backgroundColor, testDataEvents[0].textColor ), editing: .constant(false), category: ("Teste",.black, .white),eventListViewModel: EventListViewModel(), activeSheet: $activeSheet, selectedCell: ObjectToSend())
    }
    
}
#endif
