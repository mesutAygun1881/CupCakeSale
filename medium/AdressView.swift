//
//  AdressView.swift
//  medium
//
//  Created by Mesut Aygün on 20.05.2021.
//

import SwiftUI

struct AdressView: View {
    @ObservedObject var order : Order
    var body: some View {
        Form{
            Section{
            TextField("Name" ,text: $order.name)
            TextField("LastName" ,text: $order.lastName)
            TextField("Adress" ,text: $order.Adress)
            TextField("Zip" ,text: $order.Zip)
                
            }
            Section{
                NavigationLink(destination : AddRequestView(order: order)) {
                    Text("CheckOut")
                }
            
    }
    }
        .navigationBarTitle("Delivery Details", displayMode: .inline)
    }
    
}
struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        AdressView(order: Order())
    }
}
