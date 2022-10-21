//
//  FruitDetailScreen.swift
//  MY-Firebase
//
//  Created by Zaid Neurothrone on 2022-10-21.
//

import SwiftUI

struct FruitDetailScreen: View {
  @State var fruit: Fruit
  
  var body: some View {
    VStack {
      Text(fruit.name)
    }
  }
}

struct FruitDetailScreen_Previews: PreviewProvider {
  static var previews: some View {
    FruitDetailScreen(fruit: Fruit(id: UUID().uuidString, name: "Banana"))
  }
}
