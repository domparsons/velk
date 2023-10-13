//
//  ContentView.swift
//  Velk
//
//  Created by Dom Parsons on 17/08/2023.
//

import AppKit
import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    @Environment(\.managedObjectContext) var moc
    
    init() {
        let context = DataController.container.viewContext
        _viewModel = StateObject(wrappedValue: ViewModel(moc: context))
    }
    
    @State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn

    @FetchRequest(sortDescriptors: []) var folders: FetchedResults<Folder>
    
    var body: some View {
        GeometryReader { geo in
            NavigationSplitView {
                SidebarView(folders: folders, notes: viewModel.selectedFolder?.notesArray ?? [])
                    .environmentObject(viewModel)
                    .navigationSplitViewColumnWidth(min: 150, ideal: 220, max: 300)
 
            } content: {
                NotesListView(folders: folders, notes: viewModel.selectedFolder?.notesArray ?? [])
                    .environmentObject(viewModel)
                    .navigationSplitViewColumnWidth(min: 150, ideal: 220, max: 400)
                    
            } detail: {
                DetailView(folders: folders, notes: viewModel.selectedFolder?.notesArray ?? [])
                    .environmentObject(viewModel)
            }
            .navigationTitle("")
            .navigationViewStyle(.automatic)
        }
        .frame(minWidth: 700, minHeight: 350)
        .alert("Error", isPresented: $viewModel.showingErrorAlert) {
            Button("OK") {}
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, DataController.container.viewContext)
    }
}


