//
//  AddRequestView.swift
//  medium
//
//  Created by Mesut Aygün on 20.05.2021.
//

import SwiftUI

struct AddRequestView: View {
    
    @ObservedObject var order : Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    var body: some View {
        GeometryReader{ geo in
            ScrollView {
                VStack {
                    Image("cake")
                        .resizable()
                        .scaledToFit()
                        .frame(width : geo.size.width)
                    
                    Text("Your total is $\(self.order.cost , specifier :" %.2f")")
                        .font(.title)
                    
                    Button("Place Order"){
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check Out" , displayMode: .inline)
        .alert(isPresented: $showingConfirmation )  {
            Alert(title: Text("Thank you!!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
        }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakse")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "Post"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("no data : \(error?.localizedDescription ??  "unknown").")
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data){
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x\(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way"
                self.showingConfirmation = true
            }else {
                print("Invalid response")
            }
        }.resume()
        
        
    }
}

struct AddRequestView_Previews: PreviewProvider {
    static var previews: some View {
        AddRequestView(order: Order())
    }
}
