//
//  SettingsView.swift
//  ios-course-app
//
//  Created by Santiago Mattiauda on 20/11/21.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settings: SettingsFactory
    
    @State private var selectedOrder = SortingOrderType.alphabetical
    @State private var showCompletedOnly = false
    @State private var showFreeOnly = false
    @State private var showFavoriteOnly = false

    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Sort")){
                    Picker(selection: $selectedOrder, label: Text("Sort course by")){
                        ForEach(SortingOrderType.allCases, id: \.self){ orderType in
                            Text(orderType.description)
                        }
                    }
                }
                Section(header: Text("Filter")){
                    Toggle(isOn: $showCompletedOnly){
                        Text("Completed")
                    }
                    Toggle(isOn: $showFreeOnly){
                        Text("Free")
                    }
                    Toggle(isOn: $showFavoriteOnly){
                        Text("Favorite")
                    }
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName:"arrowtriangle.down.circle")
                        .font(.title)
                        .foregroundColor(.blue)
                }),
                trailing:
                Button(action: {
                    self.settings.order = self.selectedOrder
                    self.settings.showCompletedOnly = self.showCompletedOnly
                    self.settings.showFreeOnly = self.showFreeOnly
                    self.settings.showFavoriteOnly = self.showFavoriteOnly
                    
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.green)
                })
            )
        }
        .onAppear {
            self.selectedOrder = self.settings.order
            self.showCompletedOnly = self.settings.showCompletedOnly
            self.showFreeOnly = self.settings.showFreeOnly
            self.showFavoriteOnly = self.settings.showFavoriteOnly
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(SettingsFactory())
    }
}
