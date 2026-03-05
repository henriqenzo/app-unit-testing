//
//  ContentView.swift
//  UnitTesting
//
//  Created by Enzo Henrique Botelho Romão on 03/03/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TodoViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.tasks) { task in
                Text(task.text)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            viewModel.delete(task: task)
                        } label: {
                            Label("Deletar", systemImage: "trash")
                        }
                        
                        Button {
                            viewModel.startEditing(task: task)
                        } label: {
                            Label("Editar", systemImage: "pencil")
                        }
                        .tint(.blue)
                    }
            }
            
            HStack(spacing: 12) {
                TextField(text: $viewModel.addInputText) {
                    Text("Digite o nome da tarefa")
                }
                .textFieldStyle(.roundedBorder)
                
                Button("Adicionar") {
                    viewModel.addTask()
                }
            }
            .padding(24)
        }
        .sheet(isPresented: $viewModel.isEditing) {
            VStack(spacing: 32) {
                Text(viewModel.taskBeingEdited?.text ?? "")
                    .fontWeight(.bold)
                
                TextField(text: $viewModel.editInputText) {
                    Text("Digite o novo nome da tarefa")
                }
                .textFieldStyle(.roundedBorder)
                
                Button("Confirmar") {
                    viewModel.editTask()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal, 44)
            .presentationDetents([.fraction(0.3)]) 
        }
    }
}

#Preview {
    ContentView()
}
