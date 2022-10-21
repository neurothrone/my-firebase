//
//  ContentView.swift
//  MY-FirebaseExercise
//
//  Created by Zaid Neurothrone on 2022-10-21.
//

import FirebaseAuth
import SwiftUI

struct ContentView: View {
  @State private var user: User?
  @State private var isAuthenticated: Bool
  
  init() {
    isAuthenticated = Auth.auth().currentUser != nil
  }
  
  var body: some View {
    NavigationStack {
      content
        .navigationTitle("Home")
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: signOut) {
              Label("Log out", systemImage: "person")
            }
          }
        }
    }
  }
  
  @ViewBuilder
  var content: some View {
    if isAuthenticated {
      HomeScreen(isAuthenticated: $isAuthenticated)
    } else {
      AuthScreen(isAuthenticated: $isAuthenticated)
    }
  }
}

extension ContentView {
  private func signOut() {
    do {
      try Auth.auth().signOut()
    } catch {
      print("Something went wrong when signing out")
    }
    
    isAuthenticated = false
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
