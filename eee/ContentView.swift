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

//    @FetchRequest(entity: FoodEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FoodEntity.name, ascending: true)]) var food: FetchedResults<FoodEntity>
//
    @State var imageName: String = ""
//    private var items: FetchedResults<Item>

    @FetchRequest(entity: PersonalInfo.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \PersonalInfo.name, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfo.date, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfo.bloodType, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfo.emergencyContact, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfo.spareContact, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfo.photoImage, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfo.medicalRecord, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfo.medicineRecord, ascending: false)]) var personalInfo: FetchedResults<PersonalInfo>
    
    @State public var image: Data = .init(count: 0)
    @State public var show: Bool = false
    
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter
    }()
    
    var date = Date()
    
    var body: some View {
        NavigationView {

            ScrollView(.vertical, showsIndicators: false){
                ForEach(personalInfo, id: \.date) { info in
                    VStack(alignment: .leading, spacing: 15) {
                        Image(uiImage: UIImage(data: info.photoImage ?? self.image)!)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 32, height: 220)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        
                        HStack{
//                            ForEach
                            
                            Text("\(info.name ?? "")")
                        }
                    }
                }
            }
//
//            VStack(spacing:10) {
//                Image("\($imageName)")
//
//                List {
//                    ForEach(medicineImage) { medicines in
//                        Text(medicines.photoImage ?? "사진 없음")
//                    }
//                    .onDelete(perform: deleteItems)
//                }
//                .listStyle(PlainListStyle())
//                .navigationBarTitle("음식")
//                .navigationBarItems(trailing: Button(action: {
//                    addItem()
//                }){
//                    HStack{
//                        Text("사진 추가")
//                        Image(systemName: "plus")
//                    }
//                })
//            }
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newImage = PhotoEntity(context: viewContext)
//            newImage.photoImage = imageName
//
//            imageName = ""
//            saveItems()
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            guard let index = offsets.first else {return}
//            let PhotoEntity = medicineImage[index]
//            viewContext.delete(PhotoEntity)
//
//            saveItems()
//        }
//    }
//    private func saveItems() {
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
//}
//
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
