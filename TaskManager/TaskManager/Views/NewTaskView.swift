//
//  NewTaskView.swift
//  TaskManager
//
//  Created by Scott Clampet on 3/11/22.
//

import SwiftUI

struct NewTaskView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    @State var title: String = ""
    @State var description: String = ""
    @State var date: Date = Date()
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField(title.isEmpty ? "Clean the kitchen" : title, text: $title)
                } header: {
                    Text("Task Title")
                }
                
                Section {
                    TextField(description.isEmpty ? "Nothing" : description, text: $description)
                } header: {
                    Text("Task Description")
                }
                
                Section {
                    DatePicker("", selection: $date)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                } header: {
                    Text("Task Due Date")
                }

            }
            .listStyle(.insetGrouped)
            .navigationTitle("Add new task")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let task = Task(context: context)
                        
                        if taskViewModel.editTask != nil {
                            task.title = title
                            task.taskDescription = description
                        } else {
                            task.title = title
                            task.taskDescription = description
                            task.date = date
                        }
                        
                        do {
                            try context.save()
                        } catch {
                            print("Error saving new task: \(error)")
                        }
                        
                        dismiss()
                    }
                    .disabled(title.isEmpty || description.isEmpty)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let task = taskViewModel.editTask {
                    title = task.title ?? ""
                    description = task.taskDescription ?? ""
                }
            }
        }
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
    }
}
