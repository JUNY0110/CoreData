//
//  NewView.swift
//  CoreDataTest
//
//  Created by 지준용 on 2022/05/30.
//

import SwiftUI

struct NewView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var dismiss
    
    @State public var image: Data = .init(count: 0)
    @State public var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State public var show: Bool = false
    
    @State public var profileImage: Data = .init(count: 0 )
    @State public var profile: Bool = false
    
    @State public var names: String = ""
//    @State public var details: String = ""
    
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    if self.image.count != 0 {
                        Button(action: {
                            self.show.toggle()
                        }){
                            Image(uiImage: UIImage(data: self.image)!)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 120, height: 120)
                                .cornerRadius(10)
                                .shadow(radius: 4)
                        }
                    } else {
                        Button(action: {
                            self.show.toggle()
                        }){
                            Image(systemName: "photo.fill")
                                .font(.system(size: 120))
                                .foregroundColor(.gray)
                                    
                        }
                    }
                    Button(action: {
                        let add = PersonalInfoEntity(context: self.viewContext)
                        add.name = self.names
                        add.photoImage = self.image
                        
                        try! self.viewContext.save()
                        
                        self.names = ""
                        self.image.count = 0
                    }){
                        Text("create new")
                            .bold()
                            .padding()
                            .frame(width: 300, height: 50)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("create new")
            .navigationBarItems(leading: HStack{ if self.image.count != 0 { Button(action: {
                self.profile.toggle()
            }){
                Image(uiImage: UIImage(data: self.image)!)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                
            }} else {
                Button(action: {
                    self.profile.toggle()
                }){
                Image(systemName: "person.circle.fill")
                    .foregroundColor(.gray)
                }
            }} , trailing: Button(action: {
                self.dismiss.wrappedValue.dismiss()
            }){
                Text("Cancel")
                    .foregroundColor(.blue)
            })
        }.sheet(isPresented: self.$profile){
            ImagePicker(image: self.$profileImage, show: self.$show, sourceType: self.sourceType)
        }
    }
}

struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView()
    }
}
