//
//  ViewController.swift
//  APITrial
//
//  Created by 신정연 on 11/9/23.
//

import UIKit

class CameraVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // UI 요소를 프로퍼티로 선언합니다.
    let imageView = UIImageView()
    let cameraButton = UIButton()
    let photoLibraryButton = UIButton()
    var shouldOpenCamera: Bool = false
    var shouldOpenAlbum: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the image view
        setupImageView()
        // Setup the buttons
        setupButtons()
        // Setup the constraints
        setupConstraints()
    }
    
    // ImageView 설정
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray // 배경색 설정, 이미지가 없을 때 구분하기 쉽게
        view.addSubview(imageView)
    }
    
    // 버튼 설정
    private func setupButtons() {
        cameraButton.setTitle("카메라", for: .normal)
        cameraButton.backgroundColor = .blue
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        view.addSubview(cameraButton)
        
        photoLibraryButton.setTitle("앨범", for: .normal)
        photoLibraryButton.backgroundColor = .green
        photoLibraryButton.addTarget(self, action: #selector(photoLibraryButtonTapped), for: .touchUpInside)
        view.addSubview(photoLibraryButton)
    }
    
    // 레이아웃 설정
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        photoLibraryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // ImageView constraints
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            // Camera button constraints
            cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cameraButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            cameraButton.widthAnchor.constraint(equalToConstant: 100),
            cameraButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Photo library button constraints
            photoLibraryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoLibraryButton.topAnchor.constraint(equalTo: cameraButton.bottomAnchor, constant: 10),
            photoLibraryButton.widthAnchor.constraint(equalToConstant: 100),
            photoLibraryButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Selectors for button actions
    
    // 카메라를 열기 위한 메서드
    @objc func cameraButtonTapped() {
        openCamera()
    }
    
    // 사진 라이브러리를 열기 위한 메서드
    @objc func photoLibraryButtonTapped() {
        openPhotoLibrary()
    }
    
    // MARK: - Image Picker methods
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false // 필요에 따라 true로 설정하여 편집을 허용할 수 있음
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // UIImagePickerController가 이미지를 선택하면 호출되는 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.image = pickedImage // 이미지 뷰에 선택한 이미지를 표시
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 사용자가 취소했을 때 호출되는 메서드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
