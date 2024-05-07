//
//  ContentView.swift
//  swift ui 7
//
//  Created by Ann Dosova on 6.05.24.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userBuy: UserBuy
    var text: String
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("Buy, \(text), \(userBuy.caps) caps")
            Text("Second View: \(text)")
            
            .navigationBarItems(
                leading: Button("Back to menu") {
                    self.presentation.wrappedValue.dismiss()
                },
                trailing:
                    HStack {
                        Button("-") {
                            guard self.userBuy.caps > 0 else { return }
                            userBuy.caps -= 1
                        }
                        
                        Button("+") {
                            userBuy.caps += 1
                        }
                    }
            )
        }
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            self.userBuy.caps = 0
        }
    }
}

class UserBuy: ObservableObject {
    @Published var caps = 0
}

struct ContentView: View {
    @ObservedObject var userBuy = UserBuy()
    @State var tags = [String]()
    
    let coffe = "Coffe"
    let tea = "Teav"
    
    var body: some View {
        NavigationStack(path: $tags) {
        //NavigationStack {
            VStack(spacing: 30) {
                Text("You chose \(userBuy.caps) caps")
                Text("What would you like?")
                
                Button("Go") {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        tags.append("tag1")
                    }

                }
               
//                NavigationLink(destination: DetailView(text: coffe)) {
//                    Text(coffe)
//                }
                
                
//                NavigationLink(destination: DetailView(text: coffe), tag: "act1", selection: $selector, label: {
//                    EmptyView()
//                })
//                
//                
//                NavigationLink(destination: DetailView(text: coffe), tag: "act2", selection: $selector, label: {
//                    EmptyView()
//                })
                
//                NavigationLink(destination: DetailView(text: tea)) {
//                    Text(tea)
//                }
                
            }
            .navigationDestination(for: String.self) { selector in
                if selector == "tag1" {
                    DetailView(text: coffe)
                } else if selector == "tag2" {
                    DetailView(text: tea)
                }
            }
        }.environmentObject(userBuy)
    }
}

//#Preview {
//    ContentView(, tags: $tags)
//}
