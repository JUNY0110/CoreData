//
//  ContentView.swift
//  eeeee
//
//  Created by 지준용 on 2022/05/27.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: FoodEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FoodEntity.name, ascending: true)]) var food: FetchedResults<FoodEntity>
    @State var textFieldTitle: String = ""
//    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            
            VStack(spacing:10) {
                TextField("", text: $textFieldTitle)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground).cornerRadius(10))
                    .padding(.horizontal, 10)
                    
                Button(action: {
                    addItem()
                }){
                    Text("저장")
                        .padding()
                        .font(.system(size: 20, weight: .bold, design: .rounded)) .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .foregroundColor(.white)
                        .background(Color.orange.cornerRadius(10))
                        .padding(.horizontal, 10)
                }
            
            
                List {
                    ForEach(food) { foods in
                        Text(foods.name ?? "아이템 없음")
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("음식")
                .navigationBarItems(trailing: Button(action: addItem){
                    Label("아이템 추가", systemImage: "plus")
                        .labelStyle(.titleAndIcon)
                })
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newFood = FoodEntity(context: viewContext)
            newFood.name = textFieldTitle

            textFieldTitle = ""
            saveItems()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else {return}
            let FoodEntity = food[index]
            viewContext.delete(FoodEntity)

            saveItems()
        }
    }
    private func saveItems() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
