//
//  ContentView.swift
//  LearningCoreData
//
//  Created by 지준용 on 2022/06/07.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //ContentView가 CoreDataApp의 자식이므로, @Environment를 만들어 키경로를 전달해야 한다.
    //이 변수를 일종의 '스크래치 패드'로 생각한다.
    
    @Environment(\.managedObjectContext) private var viewContext
    
    

    //날짜 또는 이름 기준으로 정렬하는 등 가능. 기본적으로 이 속성래퍼를 넣으면 정렬된다.
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: true)])
    //저장된 모든 작업을 추적하여 목록을 만들고 표시할 수 있다. 사용자에게 전달하므로 task라는 변수를 생성하고 일반 타입을 가져오는 fetchedResults 타입이 된다. Xcode는 테스트를 초기화한 적이 없기에 불평하게 된다. 이를 해결하기 위한 속성으로는 @FetchRequest가 있다.//저장된 모든 작업을 추적하여 목록을 만들고 표시할 수 있다. 사용자에게 전달하므로 task라는 변수를 생성하고 일반 타입을 가져오는 fetchedResults 타입이 된다. Xcode는 테스트를 초기화한 적이 없기에 불평하게 된다. 이를 해결하기 위한 속성으로는 @FetchRequest가 있다.
    var tasks: FetchedResults<Task>
    


    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    Text(task.title ?? "Untitled")
                        .onTapGesture(count: 1, perform: {
                            updateTask(task)
                        })
                }.onDelete(perform: deleteTask)
            }
            .navigationTitle("Todo List")
            .navigationBarItems(trailing: Button("Add Task") {
                addTask()
            })
            Text("Select an item")
        }
    }

    private func addTask() {
        
        //갑자기 생성되는 모양새가 아닌, 슬라이드 형식으로 생성되게 하는 animation
        withAnimation{
            //newTask를 생성하여 viewContext에서 context를 추적하도록 함.
            let newTask = Task(context: viewContext)
            newTask.title = "New Task\(Date())"
            newTask.date = Date()
            
            //변경된 내용을 저장해야하는데, 때때로 동작하지 않을 수 있다. 예를 들면 핸드폰에 충분한 공간이 없는 등 여러 이유가 있을 수 있기 때문이다.
            //이러한 오류 사례를 잡기 위해 do try catch를 이용해 do try에서는 저장을 시도하고, catch에서는 저장하지 않은 경우를 시도할 것이다.
            saveContext()
        }
    }
    
    private func saveContext() {
        //변경된 내용을 저장해야하는데, 때때로 동작하지 않을 수 있다. 예를 들면 핸드폰에 충분한 공간이 없는 등 여러 이유가 있을 수 있기 때문이다.
        //이러한 오류 사례를 잡기 위해 do try catch를 이용해 do try에서는 저장을 시도하고, catch에서는 저장하지 않은 경우를 시도할 것이다.
        do{
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    private func deleteTask(offsets: IndexSet) {
        withAnimation{
            offsets.map{ tasks [$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
    private func updateTask(_ task: FetchedResults<Task>.Element) {
        withAnimation{
            task.title = "Update"
            saveContext()
        }
    }
}
