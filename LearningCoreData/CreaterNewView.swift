//
//  CreaterNewView.swift
//  LearningCoreData
//
//  Created by 지준용 on 2022/06/08.
//

import SwiftUI



struct CreaterNewView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var dismiss
    
    @State public var image: Data = .init(count: 0)
    @State public var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State public var show: Bool = false
    @State public var profile: Bool = false
    
    @State public var names: String = ""
    @State public var details: String = ""
    
    
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
                    TextField("Name...", text: self.$names)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Detail...", text: self.$details)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        let add = Saving(context: self.moc)
                        add.name = self.names
                        add.imageD = self.image
                        add.detail = self.details
                        add.date = Date()
                        
                        try! self.moc.save()
                        
                        self.names = ""
                        self.details = ""
                        self.image.count = 0
                    }) {
                        Text("Create new")
                            .bold()
                            .padding()
                            .frame(width: 300, height: 50)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }.foregroundColor(.white)
                        .background(self.names.count > 4 && self.details.count > 8 && self.image.count != 0 ? Color.blue : Color.gray)
                        .disabled(self.names.count > 4 && self.details.count > 8 && self.image.count != 0 ? true : false)
                }.sheet(isPresented: self.$profile, content: {
                    ImagePicker(images: self.$image, show: self.$profile, sourceType: self.sourceType)
                })
                
                

            }
            .navigationTitle("create new")
            .navigationBarItems(leading: HStack { if self.image.count != 0 { Button(action: {
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
                }) {
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(.gray)
                }
            }},trailing: Button(action: {
                self.dismiss.wrappedValue.dismiss()
            }){
                Text("Cancel")
                    .foregroundColor(.blue)
            })
        }.sheet(isPresented: self.$show, content: {
            ImagePicker(images: self.$image, show: self.$show, sourceType: self.sourceType)
        })
        
    }
}



struct CreaterNewView_Previews: PreviewProvider {
    static var previews: some View {
        CreaterNewView()
    }
}


struct ImagePicker: UIViewControllerRepresentable {

    
    @Binding var images: Data
    @Binding var show: Bool

    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    private var url: URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0].appendingPathComponent("image.jpg")
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
//        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
//        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let img0: ImagePicker
        init(img1: ImagePicker) {
            img0 = img1
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.img0.show.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            let image = info[.originalImage] as! UIImage

            let data = image.jpegData(compressionQuality: 0.5)
            self.img0.images = data!
            self.img0.show.toggle()
            
        }
    }
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(img1: self)

    }
}
