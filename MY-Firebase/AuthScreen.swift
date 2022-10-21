//
//  AuthScreen.swift
//  MY-FirebaseExercise
//
//  Created by Zaid Neurothrone on 2022-10-21.
//

import FirebaseAuth
import SwiftUI

struct AuthScreen: View {
  private enum Field {
    case email, password
  }
  
  @Binding var isAuthenticated: Bool
  
  @FocusState private var focusedField: Field?
  
  @State private var email = ""
  @State private var password = ""
  
  @State private var isLoginPresented = true
  
  private var isFormValid: Bool {
    !email.isEmpty && !password.isEmpty
  }
  
  var body: some View {
    content
      .navigationTitle("Authentication")
      .onSubmit {
        switch focusedField {
        case .email:
          focusedField = .password
        case .password:
          signUp()
        default:
          focusedField = nil
        }
      }
      .toolbar {
        ToolbarItemGroup(placement: .keyboard) {
          Spacer()
          Button("Dismiss", action: { focusedField = nil })
        }
      }
  }
  
  var content: some View {
    ZStack {
      Color.blue
        .ignoresSafeArea()
      
      VStack {
        VStack {
          Text(isLoginPresented ? "Log In" : "Sign Up")
            .font(.largeTitle)
            .foregroundColor(.white)
          
          Group {
            TextField("Email", text: $email)
              .focused($focusedField, equals: .email)
              .keyboardType(.emailAddress)
              .autocorrectionDisabled(true)
              .textInputAutocapitalization(.never)
              .submitLabel(.next)
            
            SecureField("Password", text: $password)
              .focused($focusedField, equals: .password)
              .submitLabel(.done)
          }
          .textFieldStyle(.roundedBorder)
          
          Group {
            if isLoginPresented {
              Button("Log in", action: logIn)
            } else {
              Button("Sign up", action: signUp)
            }
          }
          .buttonStyle(.borderedProminent)
          .frame(maxWidth: .infinity, alignment: .trailing)
          .padding(.top)
          .disabled(!isFormValid)
          
        }
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 20)
            .fill(.secondary)
        )
        .padding()
        .shadow(radius: 5)
        
        Spacer()
        
        Button {
          withAnimation(.linear) {
            isLoginPresented.toggle()
          }
        } label: {
          Group {
            if isLoginPresented {
              Label("Sign up", systemImage: "person.fill.xmark")
            } else {
              Label("Log in", systemImage: "person.fill.checkmark")
            }
          }
          .padding(10)
        }
        .buttonStyle(.borderedProminent)
        .tint(.mint)
      }
    }
  }
}

extension AuthScreen {
  private func logIn() {
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
      if let error {
        print(error)
      } else {
        print("✅ -> Logged in")
        isAuthenticated = true
      }
    }
  }
  
  private func signUp() {
    Auth.auth().createUser(withEmail: email, password: password) { result, error in
      if let error {
        print(error)
      } else {
        print("✅ -> Registered!")
        isAuthenticated = true
      }
    }
  }
}

struct AuthScreen_Previews: PreviewProvider {
  static var previews: some View {
    AuthScreen(isAuthenticated: .constant(false))
  }
}
