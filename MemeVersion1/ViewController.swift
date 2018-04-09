//
//  ViewController.swift
//  MemeVersion1
//
//  Created by Shane Sealy on 3/10/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Text attributes
        
        let memeTextAttributes: [String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -4.0 ]
        
        // Configure text field attributes to top and bottom textfields
        func configure(_ textField: UITextField, with defaultText: String) {
            if defaultText == "Top" || defaultText == "Bottom"  {
                topTextField.text = "Top"
                bottomTextField.text = "Bottom"
                textField.delegate = self
                textField.defaultTextAttributes = memeTextAttributes
                textField.textAlignment = .center
            }
        }
        
        configure(topTextField, with: "Top")
        configure(bottomTextField, with: "Bottom")
    }
    
    func pickAnImage(from source: UIImagePickerControllerSourceType) {
        if source == .photoLibrary || source == .camera {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func pickAnImageFromCamera(_ sender:Any) {
        pickAnImage(from: .camera)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender:Any) {
        pickAnImage(from: .photoLibrary)
    }
        // function telling the delegate the user picked a still image or movie
    
    @IBAction func sharePicture(_ sender: Any) {
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
        controller.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, activityError: Error?) -> Void in
         if completed == true {
          self.save()
         } else {
            self.dismiss(animated: true, completion: nil)
            }
         }
    }
    
    @IBAction func cancel() {
      topTextField.text = "Top"
      bottomTextField.text = "Bottom"
      imagePickerView.image = nil
    }
    
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = chosenImage
            imagePickerView.contentMode = .scaleAspectFit
            dismiss(animated: true, completion: nil)
        }
    }
        // function telling the delegate the user cancelled the pick operation
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled =  UIImagePickerController.isSourceTypeAvailable(.camera)
        if imagePickerView.image == nil {
            shareButton.isEnabled = false
        } else {
           shareButton.isEnabled = true
        }
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
        view.frame.origin.y -= getKeyboardHeight(notification)
       }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if topTextField.text == "Top" || bottomTextField.text == "Bottom"{
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
    }
    
    struct Meme {
        let topTextField: String!
        let bottomTextField: String!
        let originalImage: UIImage!
        let memedImage: UIImage!
    }
    
    func save() {
        
        let memedImage = generateMemedImage()
        let meme = Meme(topTextField: topTextField.text!, bottomTextField: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
    }
    
    func hideNaviAndToolbar(hidebars: Bool) {
        if hidebars == true {
          self.navigationBar.isHidden = true
          self.toolBar.isHidden = true
        } else {
          self.navigationBar.isHidden = false
          self.toolBar.isHidden = false
        }
    }
    
    func generateMemedImage() -> UIImage {
        
        hideNaviAndToolbar(hidebars: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideNaviAndToolbar(hidebars: false)
        
        return memedImage
       }
    }

// Sources:
// Udacity IOS program (UIKit fundamentals), Udacity forums, and mentor.

