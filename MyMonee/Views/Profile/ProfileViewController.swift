//
//  ProfileViewController.swift
//  MyMonee
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var editWhite: UIButton!
    @IBOutlet weak var editBlue: UIButton!
    @IBOutlet weak var editDone: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var lableProfileName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        textName.text = dataProfile.name
        
        editBlue.isHidden = true
        editWhite.isHidden = true
        editDone.isHidden = true
        textName.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        lableProfileName.text = dataProfile.name
    }
    
    
    @IBAction func editTap(_ sender: Any) {
        editBlue.isHidden = false
        editWhite.isHidden = false
        editDone.isHidden = false
        
        editButton.isHidden = true
    }
    
    @IBAction func editImage(_ sender: Any) {
        showImagePickerController()
    }
    
    @IBAction func doneEdit(_ sender: Any) {
        let controller = ProfileViewController(nibName: String(describing: ProfileViewController.self), bundle: nil)
        
        editBlue.isHidden = true
        editWhite.isHidden = true
        editDone.isHidden = true
        
        editButton.isHidden = false
    
        textName.isHidden = true
        dataProfile.name = textName.text ?? ""
        lableProfileName.text = dataProfile.name
        
        controller.modalPresentationStyle = .fullScreen
        
        navigationController?.popToRootViewController(animated: true)

    }
    
    @IBAction func editName(_ sender: Any) {
        if (textName.isHidden == true){
            textName.isHidden = false
        } else {
            textName.isHidden = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textName.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dataProfile.name = textName.text ?? ""
        textField.resignFirstResponder()
        return true
    }
}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImageView.image = editedImage
        } else if let originalImage =  info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImageView.image = originalImage
        }
    
        dismiss(animated: true, completion: nil )
        
    }
}
