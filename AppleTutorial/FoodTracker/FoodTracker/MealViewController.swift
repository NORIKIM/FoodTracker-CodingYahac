//
//  ViewController.swift
//  FoodTracker
//
//  Created by 김지나 on 30/07/2019.
//  Copyright © 2019 김지나. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal: Meal?
    
   
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // 사용자가 텍스트필드에 타이핑 중일 때 이미지뷰를 탭해도 키보드를 숨긴다.
        nameTextField.resignFirstResponder()
        // UIImagePickerController : 사용자가 포토앨범에서 사진을 선택할 수 있게 해주는 뷰컨트롤러
        let imagePickerController = UIImagePickerController()
        // photoLibrary에서만 사진을 선택하도록 한다.
        imagePickerController.sourceType = .photoLibrary
        // 사용자가 이미지를 선택했다는 것을 뷰컨트롤러에 알린다.
        imagePickerController.delegate = self
        // 알림을 받고 포토앨범을 모달로 띄운다.
        present(imagePickerController, animated: true, completion: nil)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //mealNameLabel.text = textField.text
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // info dictionary는 이미지의 여러 표현을 포함할 수 있다. 이미지 원본을 사용한다.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // 선택된 이미지를 뷰에 보여준다.
        photoImageView.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }

}

