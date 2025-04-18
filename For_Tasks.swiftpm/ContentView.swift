import SwiftUI
import Foundation

struct Tasks: Identifiable{
    let id = UUID()
    var title: String
    var description: String
}

struct ContentView: View{
    @State private var titletext: String = ""
    @State private var InputText: String = ""
    @State private var ListOfTasks: [Tasks] = []
    
    var body: some View{
        NavigationView{
            VStack{
                TextField("Добавить заголовок",text: $titletext)
                    .padding()
                TextField("Описание задачи", text: $InputText)
                    .padding()
                Button(action: addTask){
                    Label("Добавить задачу", systemImage: "plus.circle")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(titletext.isEmpty)
                List{
                    ForEach($ListOfTasks){ $task in
                        NavigationLink{
                            EditTaskView(task: $task)
                        } label:{
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .font(.headline)
                                Text(task.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }.swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    delettask(task)
                                } label: {
                                    Label("Удалить", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    private func addTask() {
        let newTask = Tasks(title: titletext,
                            description: InputText)
        
        ListOfTasks.append(newTask)
        titletext = ""
        InputText = ""
    }
    
    private func delettask(_ task: Tasks){
        ListOfTasks.removeAll{$0.id == task.id}
    }
    
}


struct EditTaskView: View{
    @Binding var task: Tasks
    @Environment(\.dismiss) private var dismiss
    var body: some View{
        Form{
            TextField("Заголовок", text: $task.title)
                .font(.headline)
            TextField("описание", text: $task.description)
                .font(.subheadline)
            HStack{
                Spacer()
                Button("Готово"){
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
        }
        .navigationTitle("Редактирование")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TaskDetailView: View{
    let task: Tasks
    var body: some View{
        HStack{
            Text(task.description)
        }
    }
}

