//
//  UpdateFolderView.swift
//  Velk
//
//  Created by Dom Parsons on 17/09/2023.
//

import SwiftUI

struct UpdateFolderView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var folders: FetchedResults<Folder>
    
    var body: some View {
        VStack {
            Picker("Select a Folder", selection: $viewModel.folderDestinationIndex) {
                ForEach(0..<folders.count, id: \.self) { index in
                    Text(folders[index].folderName ?? "Unknown Folder")
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .frame(minWidth: 500)
    }
}

//struct UpdateFolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateFolderView()
//    }
//}
