//
//  TodoViewModel.swift
//  UnitTesting
//
//  Created by Enzo Henrique Botelho Romão on 03/03/26.
//

import Combine
import Foundation

class TodoViewModel: ObservableObject {
    
    @Published var isEditing: Bool = false
    
    @Published var addInputText: String = ""
    @Published var editInputText: String = ""
    
    var taskIdToEdit: UUID?
    var taskBeingEdited: TodoTask? {
        tasks.first(where: { $0.id == taskIdToEdit })
    }
    
    @Published var tasks: [TodoTask] = [
        TodoTask(text: "Comer"),
        TodoTask(text: "Estudar"),
        TodoTask(text: "Academia")
    ]
    
    func addTask() {
        let trimmedText = addInputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        
        let newTask = TodoTask(text: trimmedText)
        tasks.append(newTask)
        addInputText = ""
    }
    
    func delete(task: TodoTask) {
        tasks.removeAll { $0.id == task.id }
    }
    
    func startEditing(task: TodoTask) {
        isEditing = true
        taskIdToEdit = task.id
    }
    
    func editTask() {
        let trimmedText = editInputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        
        guard let id = taskIdToEdit else { return }
        
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].text = trimmedText
        }
        
        editInputText = ""
        isEditing = false
    }
    
}
