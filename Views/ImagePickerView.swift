//
//  ImagePickerView.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-04-14.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var image: UIImage?
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeUIViewController(context: Context) -> UIViewController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, isPresented: $isPresented)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        @Binding var isPresented: Bool
        
        init(parent: ImagePicker, isPresented: Binding<Bool>) {
            self.parent = parent
            self._isPresented = isPresented
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.image = selectedImage
            }
            isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isPresented = false
        }
    }
}
