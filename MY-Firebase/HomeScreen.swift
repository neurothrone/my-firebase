//
//  HomeScreen.swift
//  MY-FirebaseExercise
//
//  Created by Zaid Neurothrone on 2022-10-21.
//

//import FirebaseAuth
import Firebase
import SwiftUI

struct HomeScreen: View {
  @Binding var isAuthenticated: Bool
  
//  @State private var allFruit: [String] = []
  @State private var allFruit: [Fruit] = []
  @State private var fruitName = ""
  
  private let userID: String
  private var ref: DatabaseReference! = Database.database().reference()
  private let fruitCollection = "fruits"
  
  init(isAuthenticated: Binding<Bool>) {
    _isAuthenticated = isAuthenticated
    
    guard let userID = Auth.auth().currentUser?.uid else {
      fatalError("❌ -> Failed to retrieve current user")
    }
    
    self.userID = userID
  }
  
  var body: some View {
    VStack {
      Text("Hello \(Auth.auth().currentUser?.email ?? "Unknown User")")
      
      VStack {
        HStack {
          TextField("Fruit name", text: $fruitName)
            .textFieldStyle(.roundedBorder)
            .autocorrectionDisabled(true)
          
          Button(action: addFruit) {
            Image(systemName: "plus")
              .imageScale(.large)
          }
          .buttonStyle(.borderedProminent)
          .tint(.mint)
          .disabled(fruitName.isEmpty)
        }
        .padding(.bottom)
        
        if allFruit.isEmpty {
          Text("No fruits yet...")
        } else {
          List {
            ForEach(allFruit) { fruit in
              NavigationLink(destination: FruitDetailScreen(fruit: fruit)) {
                Text(fruit.name)
              }
            }
            .onDelete(perform: deleteFruit)
          }
        }
        
        Spacer()
      }
      .padding()
      .onAppear(perform: fetchFruit)
    }
  }
}

extension HomeScreen {
  private func addFruit() {
    ref.child(fruitCollection).child(userID).childByAutoId().setValue(fruitName)
    fetchFruit()
    
    fruitName = ""
  }
  
  private func fetchFruit() {
    allFruit = []
    
    ref.child(fruitCollection).child(userID).getData { error, snapshot in
      if let error {
        assertionFailure("❌ -> Failed to fetch fruit from Firebase. Error: \(error)")
      }
      
      if let snapshot {
        for fruit in snapshot.children {
          let fruitSnap = fruit as! DataSnapshot
          let fruitID = fruitSnap.key
          let fruitName = fruitSnap.value as! String
          
          allFruit.append(Fruit(id: fruitID, name: fruitName))
        }
      }
    }
  }
  
  private func deleteFruit(atOffsets: IndexSet) {
    guard let index = atOffsets.first else { return }
    
    let fruitToDelete = allFruit[index]
    
    ref.child(fruitCollection).child(userID).child(fruitToDelete.id)
      .removeValue()
    
    allFruit.remove(at: index)
  }
}

struct HomeScreen_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreen(isAuthenticated: .constant(true))
  }
}
