//
//  ImagePicker.swift
//  EmergencyApp
//
//  Created by 지준용 on 2022/05/12.
//

import SwiftUI
import UIKit
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: Data
    @Binding var show: Bool
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Environment(\.presentationMode) private var presentationMode
    
    
    private var url: URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0].appendingPathComponent("image.jpg")
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController{
        let Picker = UIImagePickerController()
        Picker.sourceType = sourceType
        Picker.delegate = context.coordinator
        
        Picker.sourceType = sourceType
        
        
        return Picker
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
            self.img0.image = data!
            self.img0.show.toggle()
            
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(img1: self)
        
    }
//
//    func didTapButton() {
//        if let image = self.selectedImage {
//            upload(image)
//        } else {
//            shouldShowImagePicker.toggle()
//        }
//    }
//
//    func upload(_ image: UIImage) {
//        guard let imageData = image.jpegData(compressionQuality: 8.5) else {return}
//    }
}


