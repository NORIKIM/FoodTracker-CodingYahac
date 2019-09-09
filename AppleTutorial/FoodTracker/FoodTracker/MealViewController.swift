//
//  ViewController.swift
//  FoodTracker
//
//  Created by 김지나 on 30/07/2019.
//  Copyright © 2019 김지나. All rights reserved.
//

import UIKit
import os.log

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
   
    // MARK: Navigation
    @IBAction func cancle(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        updateSaveButtonState() // 텍스트 필드에 유효한 내용이 있으면 저장버튼 활성화
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState() // 텍스트 필드에 내용이 있는지 확인
        navigationItem.title = textField.text // 씬 제목을 위에서 텍스트 필드에 작성한 내용으로 한다.
        //mealNameLabel.text = textField.text
    }
    
    // 작성중일 때에는 저장 버튼을 비활성화합니다.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
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
    
    // MARK: Privae methods
    // 텍스트 필드가 비어있으면 저장 버튼 비활성화
    private func updateSaveButtonState() {
       
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}

