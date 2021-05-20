
import SwiftUI
struct ContentView: View {
    
    @ObservedObject var order = Order()
    
    
    var body: some View {
        
            NavigationView {
                VStack{
                    Image("cake")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
            
                    
            Form{ 
                Section{
               
                Picker("Select Your Cake Type", selection: $order.type) {
                    ForEach(0..<Order.types.count, id: \.self){
                    Text(Order.types[$0])
                }
            }
                Stepper(value : $order.quantity , in: 3...20) {
                    Text("Number of Cakes : \(order.quantity)")
                        }
                }
                    
                Section{
                    Toggle(isOn: $order.specialRequestEnabled.animation()) {
                        Text("Any Special Request")
                    }
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraForesting) {
                            Text("Add Extra Foresting ")
                        }
                        
                        Toggle(isOn: $order.addSprinkles) {
                            Text("Add Extra  Spinkles")
                        }
                    }
                }
                Section {
                    NavigationLink(destination : AdressView(order: order)) {
                        Text("Delivery Details")
                    }
                }
            
            
        
        .navigationBarTitle("Cupcake Corner")
            }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
