//
//  AddNewFolderView.swift
//  Velk
//
//  Created by Dom Parsons on 07/09/2023.
//

import SwiftUI

struct AddNewFolderView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add New Folder")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Folder name", text: $viewModel.newFolderName)
                .textFieldStyle(.roundedBorder)
            
            
            HStack(spacing: 20) {
                Spacer()
                Button("Cancel") {
                    viewModel.showingNewFolderSheet = false
                }
                .keyboardShortcut(.cancelAction)
                .cornerRadius(6)
                .buttonStyle(.bordered)
                
                Button("OK") {
                    viewModel.addFolder()
                }
                .keyboardShortcut(.defaultAction)
                .foregroundColor(.white)
                .cornerRadius(6)
            }

        }
        .padding()
        .frame(minWidth: 300)
    }
}

struct AddNewFolderView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewFolderView()
    }
}
